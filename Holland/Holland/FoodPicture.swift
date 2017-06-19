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

class FoodPicture: UIViewController {
    let csfoodcount:CSFoodcount = CSFoodcount()
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
        
        print(documentDirectory)
        return documentDirectory
        
    }
    
    
    
    @IBAction func btnOrder(_ sender: UIButton) {
        
        //創建資料夾
        var foodcount = CSFoodcount.FoodCount
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
        formatter.dateFormat = "MM/dd  HH:mm"
        let NowTime = formatter.string(from: now as Date)
        
        let RoomNum = self.userDefault.object(forKey: "RoomNum")
        
        //用字典存重要資料
        var GuessOrderInfo:Dictionary = ["RoomNumber" :RoomNum , "OrderTime" : NowTime , "FoodName" : lblFoodName.text , "FoodCount" : String(Int(stepCount.value))]
        
        
        //取用Firebase
        
        ref = Database.database().reference()
    self.ref.child("cWBMy1c4WxYkM7iI0PKH8Sy4j1M").setValue(["房號":GuessOrderInfo["RoomNumber"],"點餐時間": GuessOrderInfo["OrderTime"],"餐點名稱":GuessOrderInfo["FoodName"] , "餐點數量":GuessOrderInfo["FoodCount"]])
        
        //餐點數量＋1
        foodcount = foodcount + 1
        
        //存取資料
        let fileName:String = "orderinfo" + String(foodcount)
        var content = GuessOrderInfo
        
        var fileDir = documentsPath().appendingPathComponent(fileName)

        
        
        switch sender.tag {
        case 1:
            print("繼續點餐")
            let continueOrder = storyboard?.instantiateViewController(withIdentifier: "foodselect") as! FoodSelect
            self.navigationController?.pushViewController(continueOrder, animated: true)
        case 2:
            print("前往訂單")
            let Order = storyboard?.instantiateViewController(withIdentifier: "ordercheck") as! OrderCheck
            self.navigationController?.pushViewController(Order, animated: true)
        default:
            break
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
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let FoodName = self.getOrderInfo?.FoodName
        let FoodValue = self.getOrderInfo?.FoodValue
        
        
        lblFoodName.text = FoodName
        
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
