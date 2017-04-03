//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  SDWebImageCompat.swift
//  SDWebImageCompat
//
//  Created by Jamie Pinkham on 3/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
import TargetConditionals
#if !TARGET_OS_IPHONE
import AppKit
#if !UIImage
let UIImage = NSImage
#endif
#if !UIImageView
let UIImageView = NSImageView
#endif
#else
import UIKit
#endif
