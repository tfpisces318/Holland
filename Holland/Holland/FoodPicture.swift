//
//  FoodPicture.swift
//  Holland
//
//  Created by ios135 on 2017/5/22.
//  Copyright © 2017年 ios135. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftyJSON


class FoodPicture: UIViewController {
    var getOrderInfo:OrderInfo?
    var RoomMember = 2
    var FoodpicName:String?
    let userDefault = UserDefaults.standard
    
    //firebase連結
    var ref:DatabaseReference!
    
    
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var imgviewFoodpic: UIImageView!
    
    @IBOutlet weak var stepCount: UIStepper!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var txtFoodCount: UITextField!
    @IBAction func btnBack(_ sender: Any) {
        lblFoodName.text = "餐點名稱"
        self.navigationController?.popViewController(animated: true)
    }
    
    // 存取顧客所點餐點資訊
    // 取得路徑
    func documentsPath() -> URL{
        
        let documentDirectory = try!
            FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        userDefault.set(documentDirectory, forKey: "pathOrderinfo")
        print(documentDirectory)
        return documentDirectory
        
    }
    
    
    
    @IBAction func btnOrder(_ sender: UIButton) {
        
        if txtFoodCount.text == "0" {
            
            let alertController = UIAlertController(title: "未填入餐點數量", message: "請選擇餐點數量", preferredStyle: .alert)
            
            let callAction = UIAlertAction(title: "確定", style: .default) { (action) in}
            
            alertController.addAction(callAction)
            self.present(alertController, animated: true, completion: nil)
            
        }else{
            
            var foodcount = userDefault.integer(forKey: "foodcount")
            
            //餐點數量＋1
            foodcount = foodcount + 1
            
            userDefault.set(foodcount, forKey: "foodcount")
            
            //創建資料夾
            let manager = FileManager.default
            let folderName = "guessFoodOrderInfo"
            let dirName = documentsPath().appendingPathComponent(folderName)
            //判斷是否有資料夾
            do{
                try manager.createDirectory(at: dirName, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print("建立資料夾失敗")
            }
            print("建立資料夾成功")
            
            
            let now = NSDate()
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd-HH:mm"
            let NowTime = formatter.string(from: now as Date)
            
            let RoomNum = self.userDefault.object(forKey: "RoomNum")
            
            
            //用字典存重要資料
            let GuessOrderInfo:Dictionary = ["RoomNumber" :RoomNum ,"ID": foodcount, "OrderTime" : NowTime , "FoodName" : lblFoodName.text , "FoodCount" : String(Int(stepCount.value)) , "FoodPrice" :lblValue.text]
            
            let thejsData = try? JSONSerialization.data(withJSONObject: GuessOrderInfo, options: [])
            let thejsText = String(data: thejsData!, encoding: .utf8)
            print(thejsText!)
            
            
            
            
            //取用Firebase
            
            /*    ref = Database.database().reference()
             self.ref.child("cWBMy1c4WxYkM7iI0PKH8Sy4j1M").setValue(["房號":RoomNum,"點餐時間": NowTime,"餐點名稱":lblFoodName.text, "餐點數量":String(Int(stepCount.value))])
             */
            
            //存取資料
            let fileName:String = "orderinfo" + String(foodcount) + ".json"
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
                
                let path = dir.appendingPathComponent(fileName)
                
                userDefault.set(dir, forKey: "pathfordelete")
            
                
                do {
                    try thejsText?.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                }catch{
                    print(error.localizedDescription)
                }
                
            }
            
            switch sender.tag {
            case 1:
                print("繼續點餐")
                let continueOrder = storyboard?.instantiateViewController(withIdentifier: "foodselect") as! FoodSelect
                self.navigationController?.popViewController(animated: true)
            //                    .pushViewController(continueOrder, animated: true)
            case 2:
                print("前往訂單")
                let Order = storyboard?.instantiateViewController(withIdentifier: "ordercheck") as! OrderCheck
                self.navigationController?.pushViewController(Order, animated: true)
            default:
                break
                
            }
            
        }
        
    }
    @IBAction func stepSetCount(_ sender: Any) {
        let number = Int(stepCount.value)
        txtFoodCount.text = String(number)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.o
        
        
        txtFoodCount.isEnabled = false
        print((self.getOrderInfo?.testFoodcount)!)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let FoodName = self.getOrderInfo?.FoodName
        let FoodValue = self.getOrderInfo?.FoodValue
        
        
        lblFoodName.text = FoodName!
        
        FoodpicName = self.getOrderInfo?.FoodPic
        
        imgviewFoodpic.image = UIImage(named: FoodpicName!)
        lblValue.text = FoodValue
        
        
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
