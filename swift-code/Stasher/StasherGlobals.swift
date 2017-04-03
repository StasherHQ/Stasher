//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  StasherGlobals.swift
//  Stasher
//
//  Created by bhushan on 12/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
enum RelationShipToChild : Int {
    case dummyrelation
    case parent
    //default
    case family
    case friend
}

enum BearPopUpType : Int {
    case addparentbearpopup
    case thanksforaddingparentbearpopup
    case addchildbearpopup
    case thanksforaddingachildbearpopup
    case thanksforaddingachildnobankbearpopup
    case bankaccountdonebearpopup
    case bankaccountlaterbearpopup
}

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
enum ActivityType : Int {
    case atchildfundrequest
    case atfundtransferredbyparent
    case atmissionaddedbyparent
    case atmissionacceptedbychild
    case atmissioncancelledbychild
    case atmissioncancelledbyparent
    case atmissioncompletedbychild
    case atmissioncompletedbyparent
    case atmissionreminderbyparent
    case ataddparent
    case ataddchild
    case atchildrequestcancelledbyparent
    case atparentrequestcancelledbychild
}

let IS_IPHONE = (UI_USER_INTERFACE_IDIOM() == .phone)
let IS_STANDARD_IPHONE_6 = (IS_IPHONE && UIScreen.main.bounds.size.height == 667.0)
let IS_STANDARD_IPHONE_6_PLUS = (IS_IPHONE && UIScreen.main.bounds.size.height == 736.0)
let isiPhone5 = (UIScreen.main.bounds.size.height == 568)
let isiPhone4s = (!IS_STANDARD_IPHONE_6 && !IS_STANDARD_IPHONE_6_PLUS && !isiPhone5)
#if !Stasher_StasherGlobals_h
//#define Stasher_StasherGlobals_h
//********* SERVER *******//
let kREACHABILITYCHECKURL = "www.google.com"
//#define STASHER_BASE_URL                                                      @"http://54.225.115.65/stasher/api/"
let STASHER_BASE_URL = @"http:
//#define STASHER_BASE_URL                                                      @"http://localhost/stasher/api/"
let STASHER_ACCESS_TOKEN = "d4fhf576ggh895qqwh90"
//KNOX SERVER
let KNOX_LINK_BANK_URL = @"https:
let KParamsKey = "params"
let kAPIActionRegister = "register"
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
let kParamKeyUsername = "username"
let kParamKeyPassword = "password"
let kParamKeyEmail = "email"
let kParamKeyFirstname = "fname"
let kParamKeyLastname = "lname"
let kParamKeyDateOfBirth = "dob"
let kParamKeyCountry = "country"
let kParamKeyIsParent = "isparent"
let kParamKeyAction = "action"
let kParamKeyAccessToken = "accesstoken"
let kParamKeyGender = "gender"
let kParamKeyAvatar = "avatar"
let kParamKeyUserType = "usertype"
let kParamKeyUserID = "userId"
let kParamKeyChild = "child"
let kParamKeyParent = "parent"
let kParamKeyParentID = "parentId"
let kParamKeyChildID = "childId"
let kParamKeyAmount = "amount"
let kParamKeySaving = "saving"
let kParamKeyDeposit = "deposit"
let kParamKeyMissionCount = "missioncount"
let kParamKeyActive = "active"
let kParamKeyCompleted = "completed"
let kParamKeyPending = "pending"
let kParamKeyBadgeDetails = "badgedetails"
let kParamKeyPrice = "price"
let kParamKeyComment = "comment"
let kParamKeyRewardType = "rewardtype"
let kParamKeyUserFirstKnoxTID = "transactionId"
let kParamKeyUserKnoxTokenKey = "userknoxtokenkey"
let kParamKeyUserKnoxTokenPassword = "userknoxtokenpassword"
let kParamKeyTransactionID = "transactionId"
let kParamKeySaveResponseLocally = "saveresponseLocally"
let kAPIActionLogin = "login"
//Knox
let KNOXAPIKEY = "4aa327f5ac661878d6178e2c2b44aa5a9a0708d2"
let KNOXAPIPASSWORD = "7a383e494ac323569402b9f1fe591c1735906202"
let KNOX_PARAMKEYUSERNAME = "user_name"
let KNOX_PARAMKEYBANKNAME = "bank_name"
let KNOX_PARAMKEYPASSWORD = "user_pass"
let KNOX_PARAMKEYAPIKEY = "api_key"
let KNOX_PARAMKEYAPIPASSWORD = "api_pass"
/**
username
password
action
accesstoken
 **/
let kAPIActionFacebookLogIn = "facebooklogin"
let kAPIActionFaceBookRegister = "facebookregister"
let kAPIActionProfile = "profile"
let kAPIActionAllCountries = "allcountries"
let kAPIActionForgotPassword = "forgotpassword"
let kAPIActionSearchChild = "searchchild"
let kAPIActionSearchParent = "searchparent"
let kAPIActionAddChild = "addchild"
let kAPIActionAddParent = "addparent"
let kAPIActionEditProfile = "editprofile"
let kAPIActionChangePassword = "changepassword"
let kAPIActionAddMission = "addmission"
let kAPIActionEditMission = "editmission"
let kAPIActionParentActiveMissions = "activemissions"
let kAPIActionParentPendingMissions = "pendingmissions"
let kAPIActionParentCompletedMissions = "completedmissions"
let kAPIActionChildActiveMissions = "child_activemissions"
let kAPIActionChildPendingMissions = "child_pendingmissions"
let kAPIActionChildCompletedMissions = "child_completedmissions"
let kAPIActionParentCompleteMission = "actiononmission"
let kAPIActionChildCompleteMission = "completemission_child"
let kAPIActionChildAcceptMission = "acceptmission"
let kAPIActionRegistrationStepOne = "registerstep1"
let kAPIActionChildRequestPayment = "paymentrequest"
let kAPIActionRemindMission = "remind"
let kAPIActionInviteParent = "inviteparent"
let kAPIActionDeleteMission = "deletemission"
let kAPIActionParentGraph = "parent_graph"
let kAPIActionChildGraph = "child_graph"
let kAPIActionAddBankAccount = "addbankaccount"
let kAPIActionAddBankAccountChild = "addbankaccount_child"
let kAPIActionAddRelation = "acceptrelation"
let kParamKeyMissionId = "missionId"
let kParamKeyMissionStatus = "status"
let kParamKeyMyActivities = "myactivities"
let kParamKeyGlobalActivities = "activities"
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
let kAddMissionParamKeyTitle = "title"
let kAddMissionParamKeyDescription = "description"
let kAddMissionParamKeyIsTimeBased = "isTimebase"
let kAddMissionParamKeyTotalTime = "totaltime"
let kAddMissionParamKeyRewardType = "rewardtype"
let kAddMissionParamKeyRewards = "rewards"
let kAddMissionParamKeyIsPublic = "ispublic"
let kAddMissionParamKeyIsDraft = "isdraft"
let kChangePasswordParamKeyOldPassword = "oldpassword"
let kChangePasswordParamKeyNewPassword = "newpassword"
let kChangePasswordParamKeyConfirmPassword = "comfirmpassword"
//********* User Defaults Keys *********//
let kUserDefaultsIsUserLoggedIn = "userdefaults_isuserloggedin"
let kUserDefaultsLoggedInEmailId = "userdefaults_loginemailid"
let kUserDefaultsLoggedInusername = "userdefaults_username"
let kUserDefaultsUserType = "userdefaults_UserType"
let kUserDefaultsUserFirstName = "userdefaults_FirstName"
let kUserDefaultsUserLastName = "userdefaults_LastName"
let kUserDefaultsUserId = "userdefaults_Id"
let kMissionBarActiveMission = "Active Missions"
let kMissionBarPendingMission = "Pending Missions"
let kMissionBarCompletedMission = "Completed Missions"
//********** Server Codes **********//
let REGISTRATIONSUCCESSCODEVALUE: Int = 100
let REGISTRATIONERRORCODEVALUE: Int = 102
//********* VIEW ANIMATION *******//
let kAddSubviewAnimationDuration: Float = 0.3
let kRemoveSubviewAnimationDuration: Float = 0.3
//********** Badges Text *********//
let kBadgeJuniorAgent = "Junior Agent / Rookie"
let kBadgeTrainingDay = "Training Day"
let kBadgeFirstMission = "First Mission"
let kBadgeBusyBee = "Busy Bee"
let kBadgeMasterStasher = "Master Stasher"
let kNotificationIdentifier_BankTransactionFinished = "BankTransactionFinished"
//UserDefaults Keys
let kNSUDChildAddParentBearPopUpShown = "ChildAddParentBearPopUpShown"
let kNSUDShowFirstBadgeAlert = "ShowFirstBadgeAlert"
let kBearAnimationDuration: Float = 0.7
#endif
