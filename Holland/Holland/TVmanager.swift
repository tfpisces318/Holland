//
//  TVmanager.swift
//  Holland
//
//  Created by 王家豪 on 2017/6/27.
//  Copyright © 2017年 ios135. All rights reserved.
//

import UIKit
import Firebase

class TVmanager: UITableViewController {

    var IDcount:Int = 0
    var Rowcount:Int = 0
    var Sectioncount:Int = 0
    var arrID:[String] = ["ID:1" ,"ID:2" ,"ID:3" ,"ID:4" ,"ID:5" ,"ID:6" ,"ID:7" ,"ID:8" ,"ID:9" ,"ID:10" ,"ID:11" ,"ID:12" ,"ID:13" ,"ID:14" ,"ID:15" , ]
    let userDefault = UserDefaults.standard
    let RoomNum:[String] = ["101", "102", "103", "105", "106", "107", "108", "110", "201", "202", "203", "205", "206", "207", "208", "210", "211", "221", "222", "223", "301", "302", "303", "305", "306", "307", "308", "310", "311", "501", "502", "503", "505", "506", "507", "508", "510", "511", "512", "513", ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.userDefault.set(Rowcount, forKey: "Rowcount")
        self.userDefault.set(Sectioncount, forKey: "Sectioncount")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //var dicforcount:Dictionary<Int,Int> = userDefault.value(forKey: "dicforcount") as! Dictionary<Int, Int>
//        dicforcount[100] = nil
        let count = userDefault.integer(forKey: "Rowcount")
        
        
        return 10
//            dicforcount[section]!
        //arrforsection[section] as! Int
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "餐點列表"
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 60
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellSettingTableViewCell
        
        // Configure the cell...
      //  var arrforsection:Array<Int> = []
        var dicforcount = [100:100]
        var dicforCell = ["a":"a"]
        var FN,FC,FT:String?
        var FoodName:String?
        var FoodCount:String?
        var FoodTime:String?
        var rowcount:Int?
        var arrcount = 0
        var sectioncount:Int?
        let IDsection = indexPath.section
        let IDstr = "ID:" + String(indexPath.row + 1)
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        
        
        for i in RoomNum{
            for j in 1...15{
        //  ref.child("Food_Orders").child(RoomNum[IDsection]).child(IDstr).observeSingleEvent(of: .value, with: { (DataSnapshot) in
        
        ref.child("Food_Orders").child(i + "_ID:" + String(describing: j)).observeSingleEvent(of: .value, with: { (DataSnapshot) in

            if DataSnapshot.hasChildren(){
                
                //let valueFirebase = DataSnapshot.value as? NSDictionary
                
                //FoodName = valueFirebase?["餐點名稱"] as? String
                
                FoodName = DataSnapshot.childSnapshot(forPath: "餐點名稱").value as? String
                FoodCount = DataSnapshot.childSnapshot(forPath: "餐點數量").value as? String
                FoodTime = DataSnapshot.childSnapshot(forPath: "點餐時間").value as? String
                arrcount = arrcount + 1
                FN = "餐點名稱" + String(arrcount)
                FC = "餐點數量" + String(arrcount)
                FT = "點餐時間" + String(arrcount)
                dicforCell[FN!] = FoodName
                dicforCell[FC!] = FoodCount
                dicforCell[FT!] = FoodTime
                
                
                rowcount = self.userDefault.integer(forKey: "Rowcount")
                //sectioncount = self.userDefault.integer(forKey: "Sectioncount")
                
                
//                cell.FirebaseFoodName?.text = FoodName!
//                cell.FirebaseFoodCount.text = FoodCount!
//                cell.FirebaseFoodtime.text = FoodTime!

                
                rowcount = rowcount! + 1
              //  dicforcount[IDsection] = rowcount
                self.userDefault.set(rowcount, forKey: "Rowcount")
           //     self.userDefault.set(dicforcount, forKey: "dicforcount")
                
          //      self.IDcount = self.IDcount + 1
            //    self.userDefault.set(self.IDcount, forKey: "IDcount")
                
            //    arrforsection.append(rowcount!)
              //  self.userDefault.set(arrforsection, forKey: "arrforsection")
                
            }

                print("haha")
                //arrforsection.append(0)
              //  rowcount = 0
              //  dicforcount[IDsection] = rowcount
                //self.userDefault.set(dicforcount, forKey: "dicforcount")
              //  self.userDefault.set(arrforsection, forKey: "arrforsection")
            
        
        })
      
        }
    }

        
            cell.FirebaseFoodName?.text = dicforCell["餐點名稱" + String(indexPath.row + 1)]
            cell.FirebaseFoodCount.text = dicforCell["餐點數量" + String(indexPath.row + 1)]
            cell.FirebaseFoodtime.text = dicforCell["點餐時間" + String(indexPath.row + 1)]

        
        
        return cell
    }
    
  /*  func getFoodFromFirebase() -> Array<String>{
        var FoodName:String?
        
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("Food_Orders").child("203").child("ID:1").observeSingleEvent(of: .value, with: { (DataSnapshot) in
            if DataSnapshot.hasChildren(){
                
                //let valueFirebase = DataSnapshot.value as? NSDictionary
            
                //FoodName = valueFirebase?["餐點名稱"] as? String
            
                FoodName = DataSnapshot.childSnapshot(forPath: "餐點名稱").value as? String
            
                var arrForFirebase:Array<String> = [FoodName!]
                
            }
            
        })
        
        return arrForFirebase

        
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
