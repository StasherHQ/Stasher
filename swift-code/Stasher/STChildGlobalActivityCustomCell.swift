//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STChildGlobalActivityCustomCell.swift
//  Stasher
//
//  Created by bhushan on 12/01/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//
import UIKit
class STChildGlobalActivityCustomCell: UITableViewCell {

    @IBOutlet var labelDescription: UILabel!
    @IBOutlet weak var constraintLabelDescriptionHeight: NSLayoutConstraint!
    @IBOutlet var labelActivityTitle: UILabel!
    @IBOutlet var labelActivityTime: UILabel!
    @IBOutlet var activityTypeImgView: UIImageView!


    func awakeFromNib() {
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}