//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STUserCustomTableViewCell.swift
//  Stasher
//
//  Created by bhushan on 19/01/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//
import UIKit
class STUserCustomTableViewCell: UITableViewCell {

    @IBOutlet var imgViewProfilePic: UIImageView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var imgViewDivider: UIImageView!
    @IBOutlet var imgViewCellDetail: UIImageView!


    func awakeFromNib() {
        // Initialization code
        imgViewProfilePic.clipsToBounds = true
        imgViewProfilePic.layer.cornerRadius = imgViewProfilePic.frame.size.width / 2.0
        imgViewProfilePic.layer.borderColor = UIColor.clear.cgColor
        imgViewProfilePic.layer.borderWidth = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}