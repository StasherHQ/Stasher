//
//  UserIdentity.h
//  Stasher
//
//  Created by bhushan on 12/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    DUMMY,
    ADMIN,
    SUBADMIN,
    CHILDUSER,
    PARENTUSER
}UserIdentifier;


@interface STUserIdentity : NSObject
{


}

@property (nonatomic, assign) UserIdentifier userIdentity;
@property (nonatomic, strong) NSMutableDictionary *userInformationDictionary;
@property (nonatomic, assign) BOOL isUserUnderAge;
@property (nonatomic, assign) NSString *accessToken;
@property (nonatomic, assign) NSString *dateOfBirth;
@property (nonatomic, assign) NSString *country;
@property (nonatomic, assign) NSString *emailAddress;
@property (nonatomic, assign) NSString *firstName;
@property (nonatomic, assign) NSString *lastName;
@property (nonatomic, assign) NSString *gender;
@property (nonatomic, assign) NSString *username;
@property (nonatomic, assign) NSString *password;
@property (nonatomic, assign) NSString *userId;
@property (nonatomic, strong) NSNumber *activeMissionsCount;
@property (nonatomic, strong) NSNumber *pendingMissionsCount;
@property (nonatomic, strong) NSNumber *completedMissionsCount;
@property (nonatomic, strong) NSNumber *savingsAmount;
@property (nonatomic, strong) NSNumber *depositsAmount;
@property (nonatomic, assign) NSString *avatarUrlString;
@property (nonatomic, strong) NSArray *childBadgeDetailsArray;
@property (nonatomic, assign) NSString *userKnoxFirstTransactionID;
@property (nonatomic, assign) NSString *userKnoxTokenPassKey;
@property (nonatomic, assign) NSString *userKnoxTokenPassword;
@property (nonatomic, assign) NSString *userDeviceToken;

+(STUserIdentity*) sharedInstance;

- (void) setUserIdentityFieldsFromDictionary:(NSMutableDictionary*)dictionary;

- (void) flushUserInfoIdentity;

- (NSMutableArray*)getChildrenArray;
- (NSMutableArray*)getParentsArray;

- (BOOL)shouldShowTutorials;
- (BOOL)shouldShowBadgeAlert;

@end
