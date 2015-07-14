//
//  STCacheManager.h
//  Stasher
//
//  Created by bhushan on 21/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STCacheManager : NSObject
{

}



+ (STCacheManager*) sharedInstance;

//Cache Path
- (NSString *)applicationCachedJSONDirectory;

//JSON
-(NSData *)getJSONDataForAPIName:(NSString *)apiName;
-(void)saveJSONForAPIName:(NSString *)apiName JSONString:(NSString *)jsonString;



@end
