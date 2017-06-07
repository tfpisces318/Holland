//
//  FoodPicture.swift
//  Holland
//
//  Created by ios135 on 2017/5/22.
//  Copyright © 2017年 ios135. All rights reserved.
//

import UIKit

class FoodPicture: UIViewController {

    var RoomMember = 2
    var FoodpicName:String?
    
    
    @IBOutlet weak var imgviewFoodpic: UIImageView!
    
    @IBOutlet weak var stepCount: UIStepper!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var txtFoodCount: UITextField!
    @IBAction func btnBack(_ sender: Any) {
        lblFoodName.text = "餐點名稱"
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func stepSetCount(_ sender: Any) {
        let number = Int(stepCount.value)
        txtFoodCount.text = String(number)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txtFoodCount.isEnabled = false
        

//        let imgFoodpic:UIImage? = UIImage(named: "Snack1.jpg")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        lblFoodName.text = FoodSelect.FoodName
        
        FoodpicName = FoodSelect.FoodPic
       
        imgviewFoodpic.image = UIImage(named: FoodpicName!)
        

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
