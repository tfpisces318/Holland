//
//  CellSettingTableViewCell.swift
//  Holland
//
//  Created by 王家豪 on 2017/6/23.
//  Copyright © 2017年 ios135. All rights reserved.
//

import UIKit

class CellSettingTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblFoodname: UILabel!
    @IBOutlet weak var lblFoodcount: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var FirebaseCell: UILabel!
    @IBOutlet weak var FirebaseFoodName: UILabel!
    @IBOutlet weak var FirebaseFoodCount: UILabel!
    @IBOutlet weak var FirebaseFoodtime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
