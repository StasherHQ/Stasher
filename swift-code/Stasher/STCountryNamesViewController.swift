//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STCountryNamesViewController.swift
//  Stasher
//
//  Created by bhushan on 22/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol CountryNamesViewDelegate: NSObjectProtocol {
    func countryNamesViewCancelPressed()

    func countryNamesViewOkPressed(withCountryId selectedCountryIndex: Int)
}
class STCountryNamesViewController: UIViewController {
    var selectedIndexPath: IndexPath?

    weak var delegate: CountryNamesViewDelegate?
    @IBOutlet var countryNamesTableView: UITableView!
    var countryNamesArray = [Any]()
    @IBOutlet var popUpContainerView: UIView!
    @IBOutlet var selectContryLabel: UILabel!
    @IBOutlet var okButton: UIButton!
    @IBOutlet var cancelButton: UIButton!

    init(nibName nibNameOrNil: String, bundle nibBundleOrNil: Bundle, andCountryArray thisCountryArray: [Any]) {
        super.init(nibName: "STCountryNamesViewController", bundle: Bundle.main)
        
        countryNamesArray = [Any](arrayLiteral: thisCountryArray)
    
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        popUpContainerView.clipsToBounds = true
        popUpContainerView.layer.cornerRadius = 10.0
        popUpContainerView.layer.borderColor = UIColor.lightGray.cgColor
        popUpContainerView.layer.borderWidth = 1.0
        popUpContainerView.backgroundColor = UIColor.stasherPopUpBG()
        okButton.titleLabel?.font = UIFont.fontGothamRoundedMedium(withSize: 13.0)
        cancelButton.titleLabel?.font = UIFont.fontGothamRoundedMedium(withSize: 13.0)
        selectContryLabel.font = UIFont.fontGothamRoundedMedium(withSize: 13.0)
        selectContryLabel.textColor = UIColor.stasherText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    #pragma mark - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
// MARK: ----- Actions

    @IBAction func okButtonPressed(_ sender: Any) {
        if delegate?.responds(to: #selector(self.countryNamesViewOkPressedWithCountryId)) {
            if countryNamesArray.count > selectedIndexPath?.row {
                delegate?.countryNamesViewOkPressed(withCountryId: Int(selectedIndexPath?.row))
            }
        }
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        if delegate?.responds(to: #selector(self.countryNamesViewCancelPressed)) {
            delegate?.countryNamesViewCancelPressed()
        }
    }
// MARK: ----- Table Country Names

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryNamesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var simpleTableIdentifier: String = "AddChildResultCell"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: simpleTableIdentifier)
        }
        if countryNamesArray.count > indexPath.row {
            cell?.textLabel?.text = "\(countryNamesArray[indexPath.row]["country_name"])"
            cell?.textLabel?.textAlignment = .center
            cell?.selectionStyle = .blue
            cell?.textLabel?.textColor = UIColor.stasherText()
            cell?.textLabel?.font = UIFont.fontGothamRoundedMedium(withSize: 13.0)
            cell?.backgroundColor = UIColor.clear
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }
}