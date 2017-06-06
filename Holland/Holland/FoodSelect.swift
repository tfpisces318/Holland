//
//  FoodSelect.swift
//  Holland
//
//  Created by ios135 on 2017/5/22.
//  Copyright © 2017年 ios135. All rights reserved.
//

import UIKit

class FoodSelect: UIViewController ,UITableViewDataSource, UITableViewDelegate{

    var arysSnack = ["鍋燒意麵","皮蛋瘦肉粥","水餃","美味餐包"]
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var FoodTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        let ToFoodPic = storyboard?.instantiateViewController(withIdentifier: "FoodPicPage") as! FoodPicture
        self.navigationController?.pushViewController(ToFoodPic, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arysSnack.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = arysSnack[indexPath.row]
        
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
