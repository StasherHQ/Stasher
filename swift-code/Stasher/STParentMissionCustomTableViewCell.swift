//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STParentMissionCustomTableViewCell.swift
//  Stasher
//
//  Created by bhushan on 25/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol ParentMissionCustomTableCellDelegate: NSObjectProtocol {
    func completeMissionButtonPressed(withMissionDictionary dict: [AnyHashable: Any])

    func remindButtonPressed(withMissionDictionary dict: [AnyHashable: Any])

    func editMissionButtonPressed(withMissionDictionary dict: [AnyHashable: Any])
}
class STParentMissionCustomTableViewCell: UITableViewCell {

    weak var delegate: ParentMissionCustomTableCellDelegate?
    @IBOutlet var buttonComplete: UIButton!
    @IBOutlet var buttonEdit: UIButton!
    @IBOutlet var labelMissionCount: UILabel!
    @IBOutlet var labelMissionTitle: UILabel!
    var missionDictionary = [AnyHashable: Any]()
    var cellMissionTypeString: String = ""
    @IBOutlet var buttonAgent: UIButton!
    @IBOutlet var buttonTimeLeft: UIButton!
    @IBOutlet var buttonReward: UIButton!
    @IBOutlet var buttonStatus: UIButton!
    @IBOutlet var labelRewardAmount: UILabel!
    @IBOutlet var labelDueHrs: UILabel!
    @IBOutlet var giftIconImgView: UIImageView!
    @IBOutlet var imgViewChallenger: UIImageView!
    @IBOutlet var imgViewMissionStatus: UIImageView!
    @IBOutlet var imgViewDividerForCompletedMission: UIImageView!
    @IBOutlet var imgViewDivider: UIImageView!
    @IBOutlet weak var dueConstraint: NSLayoutConstraint!
    @IBOutlet weak var rewardConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusConstraint: NSLayoutConstraint!
    @IBOutlet weak var challengerConstraint: NSLayoutConstraint!
    @IBOutlet var dueProgressView: DACircularProgressView!
    @IBOutlet var imgViewMissionExpired: UIImageView!


    func awakeFromNib() {
        // Initialization code
        labelMissionCount.textColor = UIColor.stasherText()
        labelMissionCount.font = UIFont.fontGothamRoundedBook(withSize: 9.0)
        labelMissionTitle.textColor = UIColor.stasherText()
        labelMissionTitle.font = UIFont.fontGothamRoundedBold(withSize: 12.0)
        buttonComplete.titleLabel?.font = UIFont.fontGothamRoundedMedium(withSize: 11.0)
        buttonEdit.titleLabel?.font = UIFont.fontGothamRoundedMedium(withSize: 11.0)
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

    @IBAction func editMissionButtonPressed(_ sender: Any) {
        if delegate?.responds(to: #selector(self.editMissionButtonPressedWithMissionDictionary)) {
            delegate?.editMissionButtonPressed(withMissionDictionary: missionDictionary)
        }
    }

    @IBAction func completeMissionButtonPressed(_ sender: Any) {
        if (cellMissionTypeString == kMissionBarPendingMission) {
            if delegate?.responds(to: #selector(self.remindButtonPressedWithMissionDictionary)) {
                delegate?.remindButtonPressed(withMissionDictionary: missionDictionary)
            }
        }
        else {
            if delegate?.responds(to: #selector(self.completeMissionButtonPressedWithMissionDictionary)) {
                delegate?.completeMissionButtonPressed(withMissionDictionary: missionDictionary)
            }
        }
    }
}