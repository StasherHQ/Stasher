//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  DALabeledCircularProgressView.swift
//  DACircularProgressExample
//
//  Created by Josh Sklar on 4/8/14.
//  Copyright (c) 2014 Shout Messenger. All rights reserved.
//
/**
 @class DALabeledCircularProgressView
 
 @brief Subclass of DACircularProgressView that adds a UILabel.
 */
class DALabeledCircularProgressView: DACircularProgressView {
    /**
     UILabel placed right on the DACircularProgressView.
     */
    var progressLabel: UILabel?


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeLabel()
    
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initializeLabel()
    
    }
// MARK: - Internal methods
    /**
     Creates and initializes
     -[DALabeledCircularProgressView progressLabel].
     */

    func initializeLabel() {
        progressLabel = UILabel(frame: bounds)
        progressLabel?.textAlignment = .center
        progressLabel?.backgroundColor = UIColor.clear
        addSubview(progressLabel!)
    }
}