//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STCacheManager.swift
//  Stasher
//
//  Created by bhushan on 21/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import Foundation
class STCacheManager: NSObject {

    class func sharedInstance() -> STCacheManager {
        let lockQueue = DispatchQueue(label: "self")
        lockQueue.sync {
            if __instance == nil {
                __instance = STCacheManager()
            }
            return __instance
        }
    }
    //Cache Path

    func applicationCachedJSONDirectory() -> String {
        var isDirectory: Bool = true
        if !cachedJSON {
            cachedJSON = "\(NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last)/CachedJSON/"
        }
        if !FileManager.default.fileExists(atPath: cachedJSON, isDirectory: isDirectory) {
            try? FileManager.default.createDirectory(atPath: cachedJSON, withIntermediateDirectories: false, attributes: nil)
        }
        return cachedJSON
    }
    //JSON

    func getJSONData(forAPIName apiName: String) -> Data {
        var jsonData: Data?
        jsonData = Data(contentsOfFile: "\(applicationCachedJSONDirectory())\(apiName).txt")
        return jsonData!
    }

    func saveJSON(forAPIName apiName: String, jsonString: String) {
        var error: Error? = nil
        try? jsonString.write(toFile: "\(applicationCachedJSONDirectory())\(apiName).txt", atomically: true, encoding: String.Encoding.utf8)
    }

// MARK: ----- Path For Caching
// MARK: ----- Caching
    /*************** How to get Store Response Data
       NSString *jsonString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
      [[STCacheManager sharedInstance] saveJSONForAPIName:[self.userInfo objectForKey:@"action"] JSONString:jsonString];
     ***************/
    /*************** How to get Dictionary Response
     NSData *data = [[STCacheManager sharedInstance] getJSONDataForAPIName:kAPIActionProfile];
     NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
     NSLog(@"%@",responseDictionary);
     ***************/
}
var __instance: STCacheManager? = nil
var cachedJSON: String? = nil