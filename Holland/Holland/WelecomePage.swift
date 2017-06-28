//
//  WelecomePage.swift
//  Holland
//
//  Created by ios135 on 2017/5/31.
//  Copyright © 2017年 ios135. All rights reserved.
//

import UIKit
import Firebase

class WelecomePage: UIViewController {

    let userDefault = UserDefaults.standard
    
    @IBAction func btnStart(_ sender: Any) {
        let tofoodselect = storyboard?.instantiateViewController(withIdentifier: "foodselect") as! FoodSelect
        self.navigationController?.pushViewController(tofoodselect, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "返回"
        navigationItem.backBarButtonItem = backItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userDefault.set(0, forKey: "foodcount")
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
