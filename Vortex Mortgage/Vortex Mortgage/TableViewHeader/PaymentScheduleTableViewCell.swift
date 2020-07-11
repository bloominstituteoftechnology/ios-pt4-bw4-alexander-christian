//
//  PaymentScheduleTableViewCell.swift
//  Vortex Mortgage
//
//  Created by Christian Lorenzo on 6/30/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class PaymentScheduleTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var InterestInfoLabel: UILabel!
    @IBOutlet weak var principalInfoLabel: UILabel!
    @IBOutlet weak var remainingInfoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        InterestInfoLabel.layer.borderWidth = 1
        InterestInfoLabel.layer.borderColor = UIColor.black.cgColor
        InterestInfoLabel.clipsToBounds = true
        
        principalInfoLabel.layer.borderWidth = 1
        principalInfoLabel.layer.borderColor = UIColor.black.cgColor
        principalInfoLabel.clipsToBounds = true
        
        remainingInfoLabel.layer.borderWidth = 1
        remainingInfoLabel.layer.borderColor = UIColor.black.cgColor
        remainingInfoLabel.clipsToBounds = true
        
        //DarkMode for lettering:
        InterestInfoLabel.textColor = .myDarkModeColor
        principalInfoLabel.textColor = .myDarkModeColor
        remainingInfoLabel.textColor = .myDarkModeColor
    }

}
