//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STAvatarsViewController.swift
//  Stasher
//
//  Created by Bhushan on 30/04/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//
import UIKit
protocol AvatarVCDelegate: NSObjectProtocol {
    func avatarSelected(withImgName imgNameStr: String)
}
class STAvatarsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    weak var delegate: AvatarVCDelegate?
    @IBOutlet var avatarCollectionView: UICollectionView!
    @IBOutlet var headerLabel: UILabel!
    var dataArray = [Any]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        headerLabel.font = UIFont()
        var firstSection = [Any]()
        var secondSection = [Any]()
        for i in 1..<9 {
            firstSection.append("avtar_0\(i)")
            secondSection.append("avtar_0\(i)")
        }
        dataArray = [firstSection, secondSection]
            //self.dataArray = [[NSArray alloc] initWithObjects:@"avtar_01",@"avtar_02", @"avtar_03",@"avtar_04",@"avtar_05",@"avtar_06",@"avtar_07",@"avtar_08",nil];
        var cellNib = UINib(nibName: "AvatarCollectionViewCell", bundle: nil)
        avatarCollectionView.register(cellNib, forCellWithReuseIdentifier: "AvatarCollectionViewCell")
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: CGFloat(47), height: CGFloat(47))
        flowLayout.scrollDirection = .vertical
        avatarCollectionView.collectionViewLayout = flowLayout
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

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    func numberOfSections(inCollectionView collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var sectionArray: [Any]? = (dataArray[section] as? [Any])
        return sectionArray?.count!
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var data: [Any]? = (dataArray[indexPath.section] as? [Any])
        var cellData: String? = (data?[indexPath.row] as? String)
        var cellIdentifier: String = "AvatarCollectionViewCell"
        var cell: AvatarCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell?.avatarImgView?.image = UIImage(named: cellData)
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var data: [Any]? = (dataArray[indexPath.section] as? [Any])
        var cellData: String? = (data?[indexPath.row] as? String)
        if delegate?.responds(to: #selector(self.avatarSelectedWithImgName)) {
            delegate?.avatarSelected(withImgName: cellData)
        }
        navigationController?.popViewController(animated: true)
    }
}