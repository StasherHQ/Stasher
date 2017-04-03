//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STChildMissionCustomTableViewCell.swift
//  Stasher
//
//  Created by bhushan on 27/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol ChildMissionCustomTableCellDelegate: NSObjectProtocol {
    func childCompleteMissionButtonPressed(withMissionDictionary dict: [AnyHashable: Any])

    func childAcceptMissionButtonPressed(withMissionDictionary dict: [AnyHashable: Any])

    func childCancelMissionButtonPressed(withMissionDictionary dict: [AnyHashable: Any])
}
class STChildMissionCustomTableViewCell: UITableViewCell {

    weak var delegate: ChildMissionCustomTableCellDelegate?
    @IBOutlet var buttonComplete: UIButton!
    @IBOutlet var buttonCancel: UIButton!
    @IBOutlet var labelMissionCount: UILabel!
    @IBOutlet var labelMissionTitle: UILabel!
    var missionDictionary = [AnyHashable: Any]()
    var cellMissionTypeString: String = ""
    @IBOutlet var buttonChallenger: UIButton!
    @IBOutlet var buttonRemainingTime: UIButton!
    @IBOutlet var buttonReward: UIButton!
    @IBOutlet var buttonStatus: UIButton!
    @IBOutlet var labelRewardAmount: UILabel!
    @IBOutlet var labelDueHrs: UILabel!
    @IBOutlet var imgViewChallenger: UIImageView!
    @IBOutlet var giftIconImgView: UIImageView!
    @IBOutlet var imgViewMissionStatus: UIImageView!
    @IBOutlet weak var dueConstraint: NSLayoutConstraint!
    @IBOutlet weak var rewardConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusConstraint: NSLayoutConstraint!
    @IBOutlet weak var challengerConstraint: NSLayoutConstraint!
    @IBOutlet var dueProgressView: DACircularProgressView!
    @IBOutlet var imgViewDividerForCompletedMission: UIImageView!
    @IBOutlet var imgViewDivider: UIImageView!
    @IBOutlet var imgViewMissionExpired: UIImageView!


    func awakeFromNib() {
        // Initialization code
        labelMissionCount.textColor = UIColor.stasherText()
        labelMissionCount.font = UIFont.fontGothamRoundedBook(withSize: 9.0)
        labelMissionTitle.textColor = UIColor.stasherText()
        labelMissionTitle.font = UIFont.fontGothamRoundedBold(withSize: 12.0)
        buttonComplete.titleLabel?.font = UIFont.fontGothamRoundedMedium(withSize: 11.0)
        buttonCancel.titleLabel?.font = UIFont.fontGothamRoundedMedium(withSize: 11.0)
        imgViewChallenger.clipsToBounds = true
        imgViewChallenger.layer.cornerRadius = imgViewChallenger.frame.size.width / 2.0
        imgViewChallenger.layer.borderColor = UIColor.clear.cgColor
        imgViewChallenger.layer.borderWidth = 1.0
        if IS_STANDARD_IPHONE_6 {
            challengerConstraint.constant = 35.0
            dueConstraint.constant = 35.0
            rewardConstraint.constant = 35.0
            statusConstraint.constant = 35.0
        }
        else if IS_STANDARD_IPHONE_6_PLUS {
            challengerConstraint.constant = 45.0
            dueConstraint.constant = 45.0
            rewardConstraint.constant = 45.0
            statusConstraint.constant = 45.0
        }

        dueProgressView.trackTintColor = UIColor.clear
        dueProgressView.progressTintColor = UIColor.stasherMissionDueProgress()
        dueProgressView.thicknessRatio = 1.0
        dueProgressView.clockwiseProgress = true
        labelDueHrs.textColor = UIColor.stasherText()
        labelDueHrs.textAlignment = .center
        labelDueHrs.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func cancelMissionButtonPressed(_ sender: Any) {
        if (cellMissionTypeString == kMissionBarActiveMission) {
            if delegate?.responds(to: #selector(self.childCancelMissionButtonPressedWithMissionDictionary)) {
                delegate?.childCancelMissionButtonPressed(withMissionDictionary: missionDictionary)
            }
        }
        else {
            if delegate?.responds(to: #selector(self.childAcceptMissionButtonPressedWithMissionDictionary)) {
                delegate?.childAcceptMissionButtonPressed(withMissionDictionary: missionDictionary)
            }
        }
    }

    @IBAction func completeMissionButtonPressed(_ sender: Any) {
        if (cellMissionTypeString == kMissionBarActiveMission) {
            if delegate?.responds(to: #selector(self.childCompleteMissionButtonPressedWithMissionDictionary)) {
                delegate?.childCompleteMissionButtonPressed(withMissionDictionary: missionDictionary)
            }
        }
        else {
            if delegate?.responds(to: #selector(self.childCancelMissionButtonPressedWithMissionDictionary)) {
                delegate?.childCancelMissionButtonPressed(withMissionDictionary: missionDictionary)
            }
        }
    }
}