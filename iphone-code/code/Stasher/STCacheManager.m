//
//  STCacheManager.m
//  Stasher
//
//  Created by bhushan on 21/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STCacheManager.h"

static STCacheManager* __instance = nil;
static NSString* cachedJSON = nil;

@implementation STCacheManager


+ (STCacheManager*) sharedInstance
{
    @synchronized(self) {
        if ( __instance == nil ) {
            __instance = [[STCacheManager alloc] init];
        }
        return __instance;
    }
}

# pragma mark ----- Path For Caching

- (NSString *)applicationCachedJSONDirectory {
    BOOL isDirectory = YES;
    if (!cachedJSON) {
        cachedJSON = [NSString stringWithFormat:@"%@/CachedJSON/",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:cachedJSON isDirectory:&isDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachedJSON withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return cachedJSON;
}

# pragma mark ----- Caching

/*************** How to get Store Response Data
   NSString *jsonString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
  [[STCacheManager sharedInstance] saveJSONForAPIName:[self.userInfo objectForKey:@"action"] JSONString:jsonString];
 ***************/


-(void)saveJSONForAPIName:(NSString *)apiName JSONString:(NSString *)jsonString
{
    NSError *error = nil;
    [jsonString writeToFile:[NSString stringWithFormat:@"%@%@.txt", [self applicationCachedJSONDirectory], apiName] atomically:YES encoding:NSUTF8StringEncoding error:&error];
}


/*************** How to get Dictionary Response
 NSData *data = [[STCacheManager sharedInstance] getJSONDataForAPIName:kAPIActionProfile];
 NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
 NSLog(@"%@",responseDictionary);
 ***************/

-(NSData *)getJSONDataForAPIName:(NSString *)apiName
{
    NSData *jsonData;
    jsonData = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@%@.txt", [self applicationCachedJSONDirectory], apiName]];
    return jsonData;
}

@end
