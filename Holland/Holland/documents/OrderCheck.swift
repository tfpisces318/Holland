//
//  OrderCheck.swift
//  Holland
//
//  Created by 王家豪 on 2017/6/14.
//  Copyright © 2017年 ios135. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftyJSON


class OrderCheck: UIViewController ,UITableViewDataSource , UITableViewDelegate {
    
    let userDefault = UserDefaults.standard
    var ref:DatabaseReference!
    
    @IBOutlet weak var OrdertableView: UITableView!
    @IBOutlet weak var lblTatalValue: UILabel!

    @IBAction func btnsent(_ sender: UIButton) {
        
        
        let foodID = userDefault.integer(forKey: "foodcount")
        let filemanager = FileManager.default
        var RoomNum:String?
        var ID:Int?
        var OrderTime:String?
        var FoodName:String?
        var FoodCount:String?
        var FoodPrice:String?
        
        //看目前viewController有幾層
        let seeviewController:[UIViewController] = self.navigationController?.viewControllers as! [UIViewController]
        print(seeviewController.count)
        
        
        switch sender.tag {
        case 1:
            print("繼續點餐")
            //刪除資料
            for i in 1...foodID{
                var pathfordel = userDefault.url(forKey: "pathfordelete")
                let Filename = "orderinfo" + String(i) + ".json"
                pathfordel?.appendPathComponent(Filename)
                do{
                    try filemanager.removeItem(at: pathfordel!)
                }catch{
                    print(error.localizedDescription)
                }
            }

            userDefault.set(0, forKey: "foodcount")
            
            switch seeviewController.count {
            case 4:
                self.navigationController!.popToViewController(seeviewController[seeviewController.count - 2], animated: true)
            case 5:
                self.navigationController!.popToViewController(seeviewController[seeviewController.count - 3], animated: true)
            default:
                print("pop test")
            }
        case 2:
            print("送出訂單")
            
            RoomNum = jsOrderinfo(FoodID: 1)!["RoomNumber"].string
            OrderTime = jsOrderinfo(FoodID: foodID)!["OrderTime"].string
            
            let timeStr = OrderTime! + "_" + RoomNum!
            
            var dicForFirebase = ["房號":RoomNum]
            dicForFirebase.updateValue(OrderTime, forKey: "點餐時間")
            
            
            for i in 1...foodID{
                ID = jsOrderinfo(FoodID: i)!["ID"].int
                FoodName = jsOrderinfo(FoodID: i)!["FoodName"].string
                FoodCount = jsOrderinfo(FoodID: i)!["FoodCount"].string
                FoodPrice = jsOrderinfo(FoodID: i)!["FoodPrice"].string
                
                
                
                ref = Database.database().reference()
                
                
                //self.ref.queryOrdered(byChild: "Food_Orders").observe(, with: )
                self.ref.child("Food_Orders").child(RoomNum! + "_ID:" + String(describing: ID!)).setValue(["點餐時間":OrderTime , "餐點名稱": FoodName , "餐點數量":FoodCount , "餐點價格":FoodPrice])
                
                
//                dicForFirebase.updateValue(String(describing: ID!), forKey: "餐點ID" + String(i))
//                dicForFirebase.updateValue(FoodName, forKey: "餐點名稱" + String(i))
//                dicForFirebase.updateValue(FoodCount, forKey: "餐點數量" + String(i))
//                dicForFirebase.updateValue(FoodPrice, forKey: "加點價格" + String(i))
            }
            
            //刪除資料
            for i in 1...foodID{
                var pathfordel = userDefault.url(forKey: "pathfordelete")
                let Filename = "orderinfo" + String(i) + ".json"
                pathfordel?.appendPathComponent(Filename)
                do{
                    try filemanager.removeItem(at: pathfordel!)
                }catch{
                    print(error.localizedDescription)
                }
            }

            userDefault.set(0, forKey: "foodcount")
            switch seeviewController.count {
            case 4:
                self.navigationController!.popToViewController(seeviewController[seeviewController.count - 3], animated: true)
            case 5:
                self.navigationController!.popToViewController(seeviewController[seeviewController.count - 4], animated: true)
            default:
                print("pop test")
            }
            
//            let orderOK = storyboard?.instantiateViewController(withIdentifier: "GuessPage") as! WelecomePage
//            self.navigationController?.popToViewController(orderOK, animated: true)

        default:
            print("")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      //   print(jsOrderinfo(FoodID: 1)!["FoodName"].string)
        OrdertableView.dataSource = self
        OrdertableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let IDcount = userDefault.integer(forKey: "foodcount")
        return IDcount
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let IDcount = userDefault.integer(forKey: "foodcount")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        as! CellSettingTableViewCell
        
        
        for i in 1...IDcount{
            if (indexPath.row + 1) == i{
            cell.lblFoodname?.text = jsOrderinfo(FoodID: i)!["FoodName"].string
            cell.lblFoodcount.text = jsOrderinfo(FoodID: i)!["FoodCount"].string
            cell.lblFoodPrice.text = jsOrderinfo(FoodID: i)!["FoodPrice"].string
            }
        }

        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "所有訂單"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func jsOrderinfo(FoodID:Int) -> JSON?{
        var jsonData:JSON?
        let data1:Data
        let pathOrderinfo = userDefault.url(forKey: "pathOrderinfo")
        let filename:String = "orderinfo" + String(FoodID) + ".json"
        let path = pathOrderinfo?.appendingPathComponent(filename)
        
//        path
        
        //print("path = " + strpath!)
        
       // let path1 = Bundle.main.path(forResource: "foods", ofType: "json")
        
        
        do{
            try data1 = Data(contentsOf: path!)
            jsonData = JSON(data: data1)
        }catch{
            print(error.localizedDescription)
        }
        
        return jsonData
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
