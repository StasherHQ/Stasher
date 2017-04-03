//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STParentCompletedMissionCustomTableViewCell.swift
//  Stasher
//
//  Created by bhushan on 26/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STParentCompletedMissionCustomTableViewCell: UITableViewCell {

    @IBOutlet var labelMissionInfo: UILabel!
    @IBOutlet var labelMissionTitle: UILabel!
    @IBOutlet var buttonReward: UIButton!
    @IBOutlet var buttonSendReward: UIButton!
    @IBOutlet var labelRewardAmount: UILabel!
    @IBOutlet var giftIconImgView: UIImageView!


    func awakeFromNib() {
        // Initialization code
        labelMissionInfo.textColor = UIColor.stasherText()
        labelMissionInfo.font = UIFont.fontGothamRoundedBook(withSize: 9.0)
        labelMissionTitle.textColor = UIColor.stasherText()
        labelMissionTitle.font = UIFont.fontGothamRoundedBold(withSize: 12.0)
        buttonSendReward.titleLabel?.font = UIFont.fontGothamRoundedMedium(withSize: 13.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func rewardButtonPressed(_ sender: Any) {
    }

    @IBAction func sendRewardButtonPressed(_ sender: Any) {
    }
}