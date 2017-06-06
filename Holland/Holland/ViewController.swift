//
//  ViewController.swift
//  Holland
//
//  Created by ios135 on 2017/5/17.
//  Copyright © 2017年 ios135. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
   
    let RoomNum:[String] = ["101", "102", "103", "105", "106", "107", "108", "110", "201", "202", "203", "205", "206", "207", "208", "210", "211", "221", "222", "223", "301", "302", "303", "305", "306", "307", "308", "310", "311", "501", "502", "503", "505", "506", "507", "508", "510", "511", "512", "513", ]
    
    @IBOutlet var btnSt: UIButton!
    @IBOutlet var txtRoomNum: UITextField!
    @IBOutlet var txtPW: UITextField!
        @IBAction func btnStart(_ sender: Any) {
            
 
            let inputRoomNum = txtRoomNum.text
            
            //管理員帳密
            let ManagerID:String = "999"
            let ManagerPW:String = "239"
            //檢查帳密
            var CheckRoom = 0
            var CheckPW = 0

            
            if txtRoomNum.text == ManagerID && txtPW.text == ManagerPW{
                
                let ToManagerPage = storyboard?.instantiateViewController(withIdentifier: "ManagerPage") as! ManagerPage
                
                self.navigationController?.pushViewController(ToManagerPage, animated: true)
                
            }
            
            
            
            
            
            
            
                    
            if inputRoomNum == nil || inputRoomNum == ""{
                
                print("q")
                let alertController = UIAlertController(title: "未輸入房號", message: "請輸入房號 例：101 , 203 ...", preferredStyle: .alert)
                
                let callAction = UIAlertAction(title: "確定", style: .default) { (action) in}
                
                alertController.addAction(callAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
            for numofroom in RoomNum{
                if inputRoomNum == numofroom{
                    print(numofroom)
                    CheckRoom = 1
                    break
                }else{
                    CheckRoom = 0
                }
                
            }
            
            if txtPW.text == "123"{
                CheckPW = 1
            }else{
                CheckPW = 0
            }

            
 
            if CheckRoom == 0{
                let alertController = UIAlertController(title: "請輸入正確房號", message: "請輸入正確房號 例：101 , 203 ...", preferredStyle: .alert)
                
                let callAction = UIAlertAction(title: "確定", style: .default) { (action) in}
                
                alertController.addAction(callAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
            if CheckPW == 0{
                let alertController = UIAlertController(title: "請輸入正確密碼", message: "請輸入正確密碼", preferredStyle: .alert)
                
                let callAction = UIAlertAction(title: "確定", style: .default) { (action) in}
                
                alertController.addAction(callAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
            
        if CheckRoom == 1 && CheckPW == 1{
            
                let ToGuessPage = storyboard?.instantiateViewController(withIdentifier: "GuessPage") as! WelecomePage
                
                self.navigationController?.pushViewController(ToGuessPage, animated: true)
            }
            
            
}
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        for i in 0...40{
//            pkRoom.addSubview(RoomNum[i])
//        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

