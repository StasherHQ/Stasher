//
//  StasherGlobals.h
//  Stasher
//
//  Created by bhushan on 12/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//


typedef enum{
    DUMMYRELATION,
    PARENT, //default
    FAMILY,
    FRIEND
}RelationShipToChild;

typedef enum{
    ADDPARENTBEARPOPUP,
    THANKSFORADDINGPARENTBEARPOPUP,
    ADDCHILDBEARPOPUP,
    THANKSFORADDINGACHILDBEARPOPUP,
    THANKSFORADDINGACHILDNOBANKBEARPOPUP,
    BANKACCOUNTDONEBEARPOPUP,
    BANKACCOUNTLATERBEARPOPUP
}BearPopUpType;

/* Activity types
1: child  fund request  ;
2: fund transfered by parent;
3: misioon added by parent ;
4: mission accepted child ;
5: mission canceled by child ;
6: mission canceled by parent ;
7: mission completed by child;
8: mission completed by parent;
9: mission reminder by parent
10: add parent ;
11: add child ;
12: child request canceled by parent
13: parent request caanceled by child
*/

typedef enum{
    ATCHILDFUNDREQUEST,
    ATFUNDTRANSFERREDBYPARENT,
    ATMISSIONADDEDBYPARENT,
    ATMISSIONACCEPTEDBYCHILD,
    ATMISSIONCANCELLEDBYCHILD,
    ATMISSIONCANCELLEDBYPARENT,
    ATMISSIONCOMPLETEDBYCHILD,
    ATMISSIONCOMPLETEDBYPARENT,
    ATMISSIONREMINDERBYPARENT,
    ATADDPARENT,
    ATADDCHILD,
    ATCHILDREQUESTCANCELLEDBYPARENT,
    ATPARENTREQUESTCANCELLEDBYCHILD
}ActivityType;

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_STANDARD_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define IS_STANDARD_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define isiPhone5 ([[UIScreen mainScreen] bounds].size.height == 568) 
#define isiPhone4s (!IS_STANDARD_IPHONE_6 && !IS_STANDARD_IPHONE_6_PLUS && !isiPhone5)

#ifndef Stasher_StasherGlobals_h
#define Stasher_StasherGlobals_h


//********* SERVER *******//

#define kREACHABILITYCHECKURL                                                 @"www.google.com"

#define STASHER_BASE_URL                                                      @"http://54.225.115.65/stasher/api/"

#define STASHER_ACCESS_TOKEN                                                  @"d4fhf576ggh895qqwh90"

//KNOX SERVER

#define KNOX_LINK_BANK_URL                                                    @"https://nativeapi.knoxpayments.com/link"




#define KParamsKey                                                            @"params"

#define kAPIActionRegister                                                    @"register"

/**
username
password
email
fname
lname
dob
country
isparent
action
accesstoken
 **/

#define kParamKeyUsername                                                    @"username"
#define kParamKeyPassword                                                    @"password"
#define kParamKeyEmail                                                       @"email"
#define kParamKeyFirstname                                                   @"fname"
#define kParamKeyLastname                                                    @"lname"
#define kParamKeyDateOfBirth                                                 @"dob"
#define kParamKeyCountry                                                     @"country"
#define kParamKeyIsParent                                                    @"isparent"
#define kParamKeyAction                                                      @"action"
#define kParamKeyAccessToken                                                 @"accesstoken"
#define kParamKeyGender                                                      @"gender"
#define kParamKeyAvatar                                                      @"avatar"
#define kParamKeyUserType                                                    @"usertype"
#define kParamKeyUserID                                                      @"userId"
#define kParamKeyChild                                                       @"child"
#define kParamKeyParent                                                      @"parent"
#define kParamKeyParentID                                                    @"parentId"
#define kParamKeyChildID                                                     @"childId"
#define kParamKeyAmount                                                      @"amount"
#define kParamKeySaving                                                      @"saving"
#define kParamKeyDeposit                                                     @"deposit"
#define kParamKeyMissionCount                                                @"missioncount"
#define kParamKeyActive                                                      @"active"
#define kParamKeyCompleted                                                   @"completed"
#define kParamKeyPending                                                     @"pending"
#define kParamKeyBadgeDetails                                                @"badgedetails"
#define kParamKeyPrice                                                       @"price"
#define kParamKeyComment                                                     @"comment"
#define kParamKeyRewardType                                                  @"rewardtype"
#define kParamKeyUserFirstKnoxTID                                            @"transactionId"
#define kParamKeyUserKnoxTokenKey                                            @"userknoxtokenkey"
#define kParamKeyUserKnoxTokenPassword                                       @"userknoxtokenpassword"
#define kParamKeyTransactionID                                               @"transactionId"

#define kParamKeySaveResponseLocally                                         @"saveresponseLocally"

#define kAPIActionLogin                                                      @"login"


//Knox

#define KNOXAPIKEY                                                          @"4aa327f5ac661878d6178e2c2b44aa5a9a0708d2"

#define KNOXAPIPASSWORD                                                     @"7a383e494ac323569402b9f1fe591c1735906202"


#define KNOX_PARAMKEYUSERNAME                                               @"user_name"
#define KNOX_PARAMKEYBANKNAME                                               @"bank_name"
#define KNOX_PARAMKEYPASSWORD                                               @"user_pass"
#define KNOX_PARAMKEYAPIKEY                                                 @"api_key"
#define KNOX_PARAMKEYAPIPASSWORD                                            @"api_pass"







/**
username
password
action
accesstoken
 **/

#define kAPIActionFacebookLogIn                                              @"facebooklogin"

#define kAPIActionFaceBookRegister                                          @"facebookregister"

#define kAPIActionProfile                                                    @"profile"

#define kAPIActionAllCountries                                               @"allcountries"

#define kAPIActionForgotPassword                                             @"forgotpassword"

#define kAPIActionSearchChild                                                @"searchchild"

#define kAPIActionSearchParent                                               @"searchparent"

#define kAPIActionAddChild                                                   @"addchild"

#define kAPIActionAddParent                                                  @"addparent"

#define kAPIActionEditProfile                                                @"editprofile"

#define kAPIActionChangePassword                                             @"changepassword"

#define kAPIActionAddMission                                                 @"addmission"

#define kAPIActionEditMission                                                @"editmission"

#define kAPIActionParentActiveMissions                                       @"activemissions"

#define kAPIActionParentPendingMissions                                      @"pendingmissions"

#define kAPIActionParentCompletedMissions                                    @"completedmissions"

#define kAPIActionChildActiveMissions                                        @"child_activemissions"

#define kAPIActionChildPendingMissions                                       @"child_pendingmissions"

#define kAPIActionChildCompletedMissions                                     @"child_completedmissions"

#define kAPIActionParentCompleteMission                                      @"actiononmission"

#define kAPIActionChildCompleteMission                                       @"completemission_child"

#define kAPIActionChildAcceptMission                                         @"acceptmission"

#define kAPIActionRegistrationStepOne                                        @"registerstep1"

#define kAPIActionChildRequestPayment                                        @"paymentrequest"

#define kAPIActionRemindMission                                              @"remind"

#define kAPIActionInviteParent                                               @"inviteparent"

#define kAPIActionDeleteMission                                              @"deletemission"

#define kAPIActionParentGraph                                                @"parent_graph"

#define kAPIActionChildGraph                                                 @"child_graph"

#define kAPIActionAddBankAccount                                             @"addbankaccount"

#define kAPIActionAddBankAccountChild                                        @"addbankaccount_child"

#define kAPIActionAddRelation                                                @"acceptrelation"

#define kParamKeyMissionId                                                   @"missionId"

#define kParamKeyMissionStatus                                               @"status"

#define kParamKeyMyActivities                                                @"myactivities"

#define kParamKeyGlobalActivities                                            @"activities"

/******************
 title
 description
 isTimebase
 parentId
 childId
 totaltime
 rewardtype
 rewards
 ispublic
 isdraft
 ******************/
#define kAddMissionParamKeyTitle                                            @"title"
#define kAddMissionParamKeyDescription                                      @"description"
#define kAddMissionParamKeyIsTimeBased                                      @"isTimebase"
#define kAddMissionParamKeyTotalTime                                        @"totaltime"
#define kAddMissionParamKeyRewardType                                       @"rewardtype"
#define kAddMissionParamKeyRewards                                          @"rewards"
#define kAddMissionParamKeyIsPublic                                         @"ispublic"
#define kAddMissionParamKeyIsDraft                                          @"isdraft"


#define kChangePasswordParamKeyOldPassword                                   @"oldpassword"
#define kChangePasswordParamKeyNewPassword                                   @"newpassword"
#define kChangePasswordParamKeyConfirmPassword                               @"comfirmpassword"

//********* User Defaults Keys *********//
#define kUserDefaultsIsUserLoggedIn                                          @"userdefaults_isuserloggedin"
#define kUserDefaultsLoggedInEmailId                                         @"userdefaults_loginemailid"
#define kUserDefaultsLoggedInusername                                        @"userdefaults_username"
#define kUserDefaultsUserType                                                @"userdefaults_UserType"
#define kUserDefaultsUserFirstName                                           @"userdefaults_FirstName"
#define kUserDefaultsUserLastName                                            @"userdefaults_LastName"
#define kUserDefaultsUserId                                                  @"userdefaults_Id"



#define kMissionBarActiveMission                                            @"Active Missions"
#define kMissionBarPendingMission                                           @"Pending Missions"
#define kMissionBarCompletedMission                                         @"Completed Missions"

//********** Server Codes **********//

static int const REGISTRATIONSUCCESSCODEVALUE                                = 100;
static int const REGISTRATIONERRORCODEVALUE                                  = 102;

//********* VIEW ANIMATION *******//
static float const kAddSubviewAnimationDuration                              = 0.3f;
static float const kRemoveSubviewAnimationDuration                           = 0.3f;

//********** Badges Text *********//

#define kBadgeJuniorAgent                                                    @"Junior Agent / Rookie"
#define kBadgeTrainingDay                                                    @"Training Day"
#define kBadgeFirstMission                                                   @"First Mission"
#define kBadgeBusyBee                                                        @"Busy Bee"
#define kBadgeMasterStasher                                                  @"Master Stasher"

#define kNotificationIdentifier_BankTransactionFinished                      @"BankTransactionFinished"

//UserDefaults Keys
#define kNSUDChildAddParentBearPopUpShown                                    @"ChildAddParentBearPopUpShown"
#define kNSUDShowFirstBadgeAlert                                             @"ShowFirstBadgeAlert"

static float const kBearAnimationDuration                                    = 0.7f;


#endif
