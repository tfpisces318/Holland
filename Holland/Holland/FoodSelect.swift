//
//  FoodSelect.swift
//  Holland
//
//  Created by ios135 on 2017/5/22.
//  Copyright © 2017年 ios135. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrderInfo:Any{
    var FoodName:String?
    var FoodPic:String?
    var FoodValue:String?
    var testFoodcount = 0
}

class csjsonFromDate{
//    var jsonData:JSON?
    class func jsonFromData() -> JSON?{
        var jsonData:JSON?
        let path = Bundle.main.path(forResource: "foods", ofType: "json")
        let data1:Data
        let json_parsed:JSON
        do{
            try data1 = Data(contentsOf: URL(fileURLWithPath:
                path!, isDirectory: false))
            json_parsed=JSON(data: data1)
            jsonData=json_parsed
            //鍋燒意麵
            //let foodname01 = json_parsed[0]["foodContents"][0]["foodName"].string
            
        }catch{
            print(error.localizedDescription)
        }
    
        return jsonData
    }
}


class FoodSelect: UIViewController ,UITableViewDataSource, UITableViewDelegate{

    let js = csjsonFromDate.jsonFromData()
    
    var orderinfo:OrderInfo?
    let userDefault = UserDefaults.standard
    
    
    @IBAction func btnSend(_ sender: Any) {
        let foodcount:Int? = userDefault.integer(forKey: "foodcount")
        if foodcount == 0 || foodcount == nil{
            let alertController = UIAlertController(title: "請先進行點餐", message: "請先進行點餐", preferredStyle: .alert)
            
            let callAction = UIAlertAction(title: "確定", style: .default) { (action) in}
            
            alertController.addAction(callAction)
            self.present(alertController, animated: true, completion: nil)
        }else{
            let toOrdercheck = storyboard?.instantiateViewController(withIdentifier: "ordercheck") as! OrderCheck
            self.navigationController?.pushViewController(toOrdercheck, animated: true)
        }
    }
    @IBOutlet weak var FoodTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.orderinfo = OrderInfo()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return js?[section]["foodCategory"].string
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        orderinfo?.FoodValue = js?[indexPath.section]["foodPrice"].string
        
        orderinfo?.FoodName = js?[indexPath.section]["foodContents"][indexPath.row]["foodName"].string
        
        orderinfo?.FoodPic = js?[indexPath.section]["foodContents"][indexPath.row]["foodPic"].string
        
        
        let ToFoodPic = storyboard?.instantiateViewController(withIdentifier: "FoodPicPage") as! FoodPicture
        ToFoodPic.getOrderInfo=self.orderinfo
        self.navigationController?.pushViewController(ToFoodPic, animated: true)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (js?[section]["foodContents"].count)!
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = js?[indexPath.section]["foodContents"][indexPath.row]["foodName"].string
        
        
        
        let foodImg:UIImageView = UIImageView(frame: CGRect(x: 200, y: 10, width: 150, height: 100))
        
        let imgstr = js?[indexPath.section]["foodContents"][indexPath.row]["foodPic"].string
        foodImg.image = UIImage(named: imgstr!)
        cell.addSubview(foodImg)
        
        
        return cell
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
 
