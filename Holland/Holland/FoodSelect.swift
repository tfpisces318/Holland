//
//  FoodSelect.swift
//  Holland
//
//  Created by ios135 on 2017/5/22.
//  Copyright © 2017年 ios135. All rights reserved.
//

import UIKit

class FoodSelect: UIViewController ,UITableViewDataSource, UITableViewDelegate{

    var arys = ["鍋燒意麵","皮蛋瘦肉粥","水餃","美味餐包"]
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var FoodTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let snack:String = "各式宵夜/點心"
        
        return snack
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arys.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = arys[indexPath.row]
        
        let foodImg:UIImageView = UIImageView(frame: CGRect(x: 200, y: 10, width: 150, height: 100))
        let imgstr = "Food" + String(indexPath.row+1)+".jpg"
        
        foodImg.image = UIImage(named: imgstr)
        
        cell.addSubview(foodImg)
        
        
        
        
//        if indexPath.row == 0 {
//            cell.detailTextLabel?.text = "bb"
//        }
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
