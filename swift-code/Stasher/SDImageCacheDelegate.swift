//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  SDImageCacheDelegate.swift
//  Dailymotion
//
//  Created by Olivier Poitrey on 16/09/10.
//  Copyright 2010 Dailymotion. All rights reserved.
//

protocol SDImageCacheDelegate: NSObjectProtocol {
    func imageCache(_ imageCache: SDImageCache, didFind image: UIImage, forKey key: String, userInfo info: [AnyHashable: Any])

    func imageCache(_ imageCache: SDImageCache, didNotFindImageForKey key: String, userInfo info: [AnyHashable: Any])
}