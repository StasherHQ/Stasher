//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STParentMyActivityCustomCell.swift
//  Stasher
//
//  Created by bhushan on 12/01/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//
import UIKit
class STParentMyActivityCustomCell: UITableViewCell {

    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var labelActivityTitle: UILabel!
    @IBOutlet var labelActivityTime: UILabel!
    @IBOutlet var activityTypeImgView: UIImageView!
    @IBOutlet weak var constraintLabelDescriptionHeight: NSLayoutConstraint!


    func awakeFromNib() {
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}