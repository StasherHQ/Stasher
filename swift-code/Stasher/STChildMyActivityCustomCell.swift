//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STChildMyActivityCustomCell.swift
//  Stasher
//
//  Created by bhushan on 12/01/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//
import UIKit
class STChildMyActivityCustomCell: UITableViewCell {

    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var labelActivityTitle: UILabel!
    @IBOutlet var activityTypeImgView: UIImageView!
    @IBOutlet var labelActivityTime: UILabel!
    @IBOutlet weak var constraintLabelDescriptionHeight: NSLayoutConstraint!
    @IBOutlet weak var cellHeightConstraint: NSLayoutConstraint!


    func awakeFromNib() {
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}