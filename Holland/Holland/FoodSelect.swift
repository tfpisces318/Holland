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
            let foodname01 = json_parsed[0]["foodContents"][0]["foodName"].string
            
        }catch{
            print(error.localizedDescription)
        }
    
        return jsonData
    }
}


class FoodSelect: UIViewController ,UITableViewDataSource, UITableViewDelegate{

    let js = csjsonFromDate.jsonFromData()
    
    
    var arysSnack = ["鍋燒意麵（冬粉）","皮蛋瘦肉粥","水餃（附湯）","奶油餐包（附紅茶）"]
    var arysBreakfast = ["西式活力餐","中式營養餐","鍋燒意麵（冬粉）","水餃15粒（附湯）","皮蛋瘦肉粥","新鮮虱目魚粥"]
    var arysDinner = ["紅燒牛腩飯","印度咖哩雞肉飯","照燒雞腿飯（麵）","原汁牛肉麵（冬粉）","和風日式燒肉麵（冬粉）","麻油雞湯麵線","新鮮虱目魚粥","玉醬什錦素食"]
    
    //存食物名稱和照片 ->下一頁
    static var FoodName:String?
    static var FoodPic:String?
    
    var orderinfo:OrderInfo?
    
    @IBAction func btnBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var FoodTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.orderinfo = OrderInfo()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "24小時休息餐（宵夜/點心）"
        case 1:
            return "活力早餐"
        case 2:
            return "風味午、晚餐"
        default:
            return ""
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch indexPath.section {
        case 0:
            orderinfo?.FoodValue = "60"
            switch indexPath.row {
            case 0:
                orderinfo?.FoodName = "鍋燒意麵（冬粉）"
                orderinfo?.FoodPic = "Snack1.jpg"
            case 1:
                orderinfo?.FoodName = "皮蛋瘦肉粥"
                orderinfo?.FoodPic = "Snack2.jpg"
            case 2:
                orderinfo?.FoodName = "水餃（附湯）"
                orderinfo?.FoodPic = "Snack3.jpg"
            case 3:
                orderinfo?.FoodName = "奶油餐包（附紅茶）"
                orderinfo?.FoodPic = "Snack4.jpg"
            default:
                print("no act")
            }
        case 1:
            orderinfo?.FoodValue = "120"
            switch indexPath.row {
            case 0:
                orderinfo?.FoodName = "西式活力餐"
                orderinfo?.FoodPic = "Breakfast1.jpg"
            case 1:
                orderinfo?.FoodName = "中式營養餐"
                orderinfo?.FoodPic = "Breakfast2.jpg"
            case 2:
                orderinfo?.FoodName = "鍋燒意麵（冬粉）"
                orderinfo?.FoodPic = "Breakfast3.jpg"
            case 3:
                orderinfo?.FoodName = "水餃15粒（附湯）"
                orderinfo?.FoodPic = "Breakfast4.jpg"
            case 4:
                orderinfo?.FoodName = "皮蛋瘦肉粥"
                orderinfo?.FoodPic = "Breakfast5.jpg"
            case 5:
                orderinfo?.FoodName = "新鮮虱目魚粥"
                orderinfo?.FoodPic = "Breakfast6.jpg"
            default:
                print("no act")
            }
        case 2:
            orderinfo?.FoodValue = "120"
            switch indexPath.row {
            case 0:
                orderinfo?.FoodName = "紅燒牛腩飯"
                orderinfo?.FoodPic = "Dinner1.jpg"
            case 1:
                orderinfo?.FoodName = "印度咖哩雞肉飯"
                orderinfo?.FoodPic = "Dinner2.jpg"
            case 2:
                orderinfo?.FoodName = "照燒雞腿飯（麵）"
                orderinfo?.FoodPic = "Dinner3.jpg"
            case 3:
                orderinfo?.FoodName = "原汁牛肉麵（冬粉）"
                orderinfo?.FoodPic = "Dinner4.jpg"
            case 4:
                orderinfo?.FoodName = "和風日式燒肉麵（冬粉）"
                orderinfo?.FoodPic = "Dinner5.jpg"
            case 5:
                orderinfo?.FoodName = "麻油雞湯麵線"
                orderinfo?.FoodPic = "Dinner6.jpg"
            case 6:
                orderinfo?.FoodName = "新鮮虱目魚粥"
                orderinfo?.FoodPic = "Dinner7.jpg"
            case 7:
                orderinfo?.FoodName = "玉醬什錦素食"
                orderinfo?.FoodPic = "Dinner8.jpg"
            default:
                print("no act")
            }
        default:
            print("no act")
        }

        
        
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
        switch section {
        case 0:
            return arysSnack.count
        case 1:
            return arysBreakfast.count
        case 2:
            return arysDinner.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text =
                arysSnack[indexPath.row]
        case 1:
            cell.textLabel?.text =
                arysBreakfast[indexPath.row]
        case 2:
            cell.textLabel?.text =
                arysDinner[indexPath.row]
        default:
            print("null")
        }
        
        
        
        let foodImg:UIImageView = UIImageView(frame: CGRect(x: 200, y: 10, width: 150, height: 100))
        
        switch indexPath.section {
        case 0:
            let imgstr = "Snack" + String(indexPath.row+1)+".jpg"
            
            foodImg.image = UIImage(named: imgstr)
            
            cell.addSubview(foodImg)
        case 1:
            let imgstr = "Breakfast" + String(indexPath.row+1)+".jpg"
            
            foodImg.image = UIImage(named: imgstr)
            
            cell.addSubview(foodImg)
        case 2:
            let imgstr = "Dinner" + String(indexPath.row+1)+".jpg"
            
            foodImg.image = UIImage(named: imgstr)
            
            cell.addSubview(foodImg)
            

        default:
            print("aa")
        }
        
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
 
