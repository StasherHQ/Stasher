//
//  UserIdentity.m
//  Stasher
//
//  Created by bhushan on 12/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STUserIdentity.h"

static STUserIdentity* __instance = nil;

@implementation STUserIdentity

+(STUserIdentity*) sharedInstance
{
    @synchronized(self) {
        if ( __instance == nil ) {
            __instance = [[STUserIdentity alloc] init];
            __instance.accessToken = STASHER_ACCESS_TOKEN;
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserType]!=nil) {
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserType]integerValue] == 3) {
                    [__instance setUserIdentity:CHILDUSER];
                }
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserType]integerValue] == 4) {
                    [__instance setUserIdentity:PARENTUSER];
                }
            }
            if ([[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserFirstName]!=nil) {
                 [__instance setFirstName:[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserFirstName]];
            }
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserLastName]!=nil) {
                [__instance setLastName:[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserLastName]];
            }
            if ([[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsLoggedInusername]!=nil) {
                [__instance setUsername:[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsLoggedInusername]];
            }
            if ([[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserId]!=nil) {
                [__instance setUserId:[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserId]];
            }
        }
        return __instance;
    }
}

- (void) setUserIdentityFieldsFromDictionary:(NSMutableDictionary*)dictionary
{
    
}

- (void) setUserInformationDictionary:(NSMutableDictionary *)userInformationDictionary
{
    _userInformationDictionary = userInformationDictionary;
    if([_userInformationDictionary objectForKey:kParamKeyUsername])
        [self setUsername:[_userInformationDictionary objectForKey:kParamKeyUsername]];
    if([_userInformationDictionary objectForKey:kParamKeyPassword])
        [self setPassword:[_userInformationDictionary objectForKey:kParamKeyPassword]];
    if([_userInformationDictionary objectForKey:kParamKeyEmail])
        [self setEmailAddress:[_userInformationDictionary objectForKey:kParamKeyEmail]];
    if([_userInformationDictionary objectForKey:kParamKeyCountry])
        [self setCountry:[_userInformationDictionary objectForKey:kParamKeyCountry]];
    if([_userInformationDictionary objectForKey:kParamKeyDateOfBirth])
        [self setDateOfBirth:[_userInformationDictionary objectForKey:kParamKeyDateOfBirth]];
    if([_userInformationDictionary objectForKey:kParamKeyGender])
        [self setGender:[_userInformationDictionary objectForKey:kParamKeyGender]];
    if([_userInformationDictionary objectForKey:kParamKeyFirstname])
        [self setFirstName:[_userInformationDictionary objectForKey:kParamKeyFirstname]];
    if([_userInformationDictionary objectForKey:kParamKeyLastname])
        [self setLastName:[_userInformationDictionary objectForKey:kParamKeyLastname]];
    if([_userInformationDictionary objectForKey:kParamKeyUserID])
        [self setUserId:[_userInformationDictionary objectForKey:kParamKeyUserID]];
    if ([_userInformationDictionary objectForKey:kParamKeyUserFirstKnoxTID]) {
        if (![[_userInformationDictionary objectForKey:kParamKeyUserFirstKnoxTID] isKindOfClass:[NSNull class]]) {
             [self setUserKnoxFirstTransactionID:[_userInformationDictionary objectForKey:kParamKeyUserFirstKnoxTID]];
        }else{
            [self setUserKnoxFirstTransactionID:@""];
        }
    }else{
        [self setUserKnoxFirstTransactionID:@""];
    }
    if ([_userInformationDictionary objectForKey:kParamKeyUserKnoxTokenKey]) {
        [self setUserKnoxTokenPassKey:[_userInformationDictionary objectForKey:kParamKeyUserKnoxTokenKey]];
    }
    if ([_userInformationDictionary objectForKey:kParamKeyUserKnoxTokenPassword]) {
        [self setUserKnoxTokenPassword:[_userInformationDictionary objectForKey:kParamKeyUserKnoxTokenPassword]];
    }
    
    if([_userInformationDictionary objectForKey:kParamKeyAmount]){
        if ([[_userInformationDictionary objectForKey:kParamKeyAmount] objectForKey:kParamKeySaving] ) {
            [self setSavingsAmount:[NSNumber numberWithInt:[[[_userInformationDictionary objectForKey:kParamKeyAmount] objectForKey:kParamKeySaving] intValue]]];
        }
        if ([[_userInformationDictionary objectForKey:kParamKeyAmount] objectForKey:kParamKeyDeposit]){
            [self setDepositsAmount:[NSNumber numberWithInt:[[[_userInformationDictionary objectForKey:kParamKeyAmount] objectForKey:kParamKeyDeposit] intValue]]];
        }
    }
    
    if ([_userInformationDictionary objectForKey:kParamKeyMissionCount]) {
        if ([[_userInformationDictionary objectForKey:kParamKeyMissionCount] objectForKey:kParamKeyActive] && [[_userInformationDictionary objectForKey:kParamKeyMissionCount] objectForKey:kParamKeyActive]!= nil) {
            [self setActiveMissionsCount:[NSNumber numberWithInt:[[[_userInformationDictionary objectForKey:kParamKeyMissionCount] objectForKey:kParamKeyActive] intValue]]];
        }
       if ([[_userInformationDictionary objectForKey:kParamKeyMissionCount] objectForKey:kParamKeyPending] && [[_userInformationDictionary objectForKey:kParamKeyMissionCount] objectForKey:kParamKeyPending]!=nil){
            [self setPendingMissionsCount:[NSNumber numberWithInt:[[[_userInformationDictionary objectForKey:kParamKeyMissionCount] objectForKey:kParamKeyPending] intValue]]];
        }
        if ([[_userInformationDictionary objectForKey:kParamKeyMissionCount] objectForKey:kParamKeyCompleted] && [[_userInformationDictionary objectForKey:kParamKeyMissionCount] objectForKey:kParamKeyCompleted] != nil){
            [self setCompletedMissionsCount:[NSNumber numberWithInt:[[[_userInformationDictionary objectForKey:kParamKeyMissionCount] objectForKey:kParamKeyCompleted] intValue]]];
        }
    }
    
    if([_userInformationDictionary objectForKey:kParamKeyUserType])
    {
        if ([[_userInformationDictionary objectForKey:kParamKeyUserType] integerValue] == PARENTUSER) {
            [self setUserIdentity:PARENTUSER];
        }
        if ([[_userInformationDictionary objectForKey:kParamKeyUserType] integerValue] == CHILDUSER) {
            [self setUserIdentity:CHILDUSER];
        }
    }
    
    if ([_userInformationDictionary objectForKey:kParamKeyAvatar]) {
        [self setAvatarUrlString:[_userInformationDictionary objectForKey:kParamKeyAvatar]];
    }
    
    if ([_userInformationDictionary objectForKey:kParamKeyBadgeDetails]) {
        [self setChildBadgeDetailsArray:[_userInformationDictionary objectForKey:kParamKeyBadgeDetails]];
    }
}

- (void) setUserIdentity:(UserIdentifier)userIdentity
{
    _userIdentity = userIdentity;
    if (userIdentity == CHILDUSER) {
        [[NSUserDefaults standardUserDefaults] setObject:@"3" forKey:kUserDefaultsUserType];
    }
    if (userIdentity == PARENTUSER) {
        [[NSUserDefaults standardUserDefaults] setObject:@"4" forKey:kUserDefaultsUserType];
    }
}

- (void) setAccessToken:(NSString *)accessToken
{
    _accessToken = accessToken;
}

- (void) setIsUserUnderAge:(BOOL)isUserUnderAge
{
    _isUserUnderAge = isUserUnderAge;
}

- (void) setCountry:(NSString *)country
{
    _country = country;
}

- (void) setDateOfBirth:(NSString *)dateOfBirth
{
    _dateOfBirth = dateOfBirth;
}

- (void) setEmailAddress:(NSString *)emailAddress
{
    _emailAddress = emailAddress;
}

- (void) setFirstName:(NSString *)firstName
{
    _firstName = firstName;
}

- (void) setLastName:(NSString *)lastName
{
    _lastName = lastName;
}

- (void) setUsername:(NSString *)username
{
    _username = username;
}

- (void) setPassword:(NSString *)password
{
    _password = password;
}

- (void) setActiveMissionsCount:(NSNumber *)activeMissionsCount
{
    _activeMissionsCount = activeMissionsCount;
}

- (void) setPendingMissionsCount:(NSNumber *)pendingMissionsCount
{
    _pendingMissionsCount = pendingMissionsCount;
}

- (void) setCompletedMissionsCount:(NSNumber *)completedMissionsCount
{
    _completedMissionsCount = completedMissionsCount;
}

- (void) setSavingsAmount:(NSNumber *)savingsAmount
{
    _savingsAmount = savingsAmount;
}

- (void) setDepositsAmount:(NSNumber *)depositsAmount
{
    _depositsAmount = depositsAmount;
}

- (void) setAvatarUrlString:(NSString *)avatarUrlString
{
    _avatarUrlString = avatarUrlString;
}

- (void) setChildBadgeDetailsArray:(NSArray *)childBadgeDetailsArray
{
    _childBadgeDetailsArray = childBadgeDetailsArray;
}

- (void)setUserKnoxFirstTransactionID:(NSString *)userKnoxFirstTransactionID
{
    _userKnoxFirstTransactionID = userKnoxFirstTransactionID;
}

- (void)setUserKnoxTokenPassKey:(NSString *)userKnoxTokenPassKey
{
    _userKnoxTokenPassKey = userKnoxTokenPassKey;
}

- (void)setUserKnoxTokenPassword:(NSString *)userKnoxTokenPassword
{
    _userKnoxTokenPassword = userKnoxTokenPassword;
}

- (void)setUserDeviceToken:(NSString *)userDeviceToken
{
    _userDeviceToken = userDeviceToken;
}

- (NSMutableArray*)getChildrenArray
{
    NSData *data = [[STCacheManager sharedInstance] getJSONDataForAPIName:kAPIActionProfile];
    if (data!=nil) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        if (responseDictionary) {
            if ([responseDictionary objectForKey:kParamKeyChild]) {
                if ([[responseDictionary objectForKey:kParamKeyChild] isKindOfClass:[NSArray class]]) {
                    return [[responseDictionary objectForKey:kParamKeyChild] mutableCopy];
                }
            }
        }
    }
    
    return nil;
}

- (NSMutableArray*)getParentsArray
{
    NSData *data = [[STCacheManager sharedInstance] getJSONDataForAPIName:kAPIActionProfile];
    if (data!=nil){
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        if (responseDictionary) {
            if ([responseDictionary objectForKey:kParamKeyParent]) {
                if ([[responseDictionary objectForKey:kParamKeyParent] isKindOfClass:[NSArray class]]) {
                    return [[responseDictionary objectForKey:kParamKeyParent] mutableCopy];
                }
            }
        }
    }
    return nil;
}

- (BOOL)shouldShowTutorials
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:self.userId] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:self.userId];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    return NO;
}

- (BOOL)shouldShowBadgeAlert
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kNSUDShowFirstBadgeAlert] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:kNSUDShowFirstBadgeAlert];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    return NO;
}

- (void) flushUserInfoIdentity
{
    _isUserUnderAge       = NO;
    _country              = @"";
    _dateOfBirth          = @"";
    _emailAddress         = @"";
    _firstName            = @"";
    _lastName             = @"";
    _username             = @"";
    _password             = @"";
    _userInformationDictionary = nil;
    _userIdentity   = DUMMY;
    _userId               = @"";
    _avatarUrlString      = @"";
    _childBadgeDetailsArray = nil;
    _userKnoxFirstTransactionID = @"";
}

@end
