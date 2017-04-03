//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STChildMissionCompleteCustomTableViewCell.swift
//  Stasher
//
//  Created by bhushan on 27/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol STChildMissionCompletedCellDelegate: NSObjectProtocol {
    func childMissionCompletedCellRequestRewardButtonPressed(withDict dict: [AnyHashable: Any])
}
class STChildMissionCompleteCustomTableViewCell: UITableViewCell {

    weak var delegate: STChildMissionCompletedCellDelegate?
    @IBOutlet var labelMissionInfo: UILabel!
    @IBOutlet var labelMissionTitle: UILabel!
    @IBOutlet var buttonReward: UIButton!
    @IBOutlet var buttonSendReward: UIButton!
    @IBOutlet var labelRewardAmount: UILabel!
    @IBOutlet var giftIconImgView: UIImageView!
    var missionDict = [AnyHashable: Any]()


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

    @IBAction func childMissionCompleteRequestRewardButtonPressed(_ sender: Any) {
        if delegate?.responds(to: #selector(self.ChildMissionCompletedCellRequestRewardButtonPressedWithDict)) {
            delegate?.childMissionCompletedCellRequestRewardButtonPressed(withDict: missionDict)
        }
    }
}