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
    var getOrderInfo:OrderInfo?
    var RoomMember = 2
    var FoodpicName:String?
    
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
    
    @IBAction func btnOrder(_ sender: Any) {
        //取用Firebase
        
//        ref = Database.database().reference()
//        
//        self.ref.setValue(["holland-ed769": "234"])
        
        
        
        
        
        
        let Order = storyboard?.instantiateViewController(withIdentifier: "GuessPage") as! WelecomePage
        self.navigationController?.pushViewController(Order, animated: true)
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
        
        lblFoodName.text = FoodSelect.FoodName
        
        FoodpicName = FoodSelect.FoodPic
       
        imgviewFoodpic.image = UIImage(named: FoodpicName!)
        lblValue.text = self.getOrderInfo?.FoodValue
        

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
