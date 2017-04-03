//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  UserIdentity.h
//  Stasher
//
//  Created by bhushan on 12/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import Foundation
enum UserIdentifier : Int {
    case dummy
    case admin
    case subadmin
    case childuser
    case parentuser
}

class STUserIdentity: NSObject {

    var userIdentity: UserIdentifier {
        get {
            // TODO: add getter implementation
        }
        set(userIdentity) {
            self.userIdentity = userIdentity
            if userIdentity == .childuser {
                UserDefaults.standard.set("3", forKey: kUserDefaultsUserType)
            }
            if userIdentity == .parentuser {
                UserDefaults.standard.set("4", forKey: kUserDefaultsUserType)
            }
        }
    }
    var userInformationDictionary: [AnyHashable: Any] {
        get {
            // TODO: add getter implementation
        }
        set(userInformationDictionary) {
            self.userInformationDictionary = userInformationDictionary
            if self.userInformationDictionary[kParamKeyUsername] {
                username = self.userInformationDictionary[kParamKeyUsername]
            }
            if self.userInformationDictionary[kParamKeyPassword] {
                password = self.userInformationDictionary[kParamKeyPassword]
            }
            if self.userInformationDictionary[kParamKeyEmail] {
                emailAddress = self.userInformationDictionary[kParamKeyEmail]
            }
            if self.userInformationDictionary[kParamKeyCountry] {
                country = self.userInformationDictionary[kParamKeyCountry]
            }
            if self.userInformationDictionary[kParamKeyDateOfBirth] {
                dateOfBirth = self.userInformationDictionary[kParamKeyDateOfBirth]
            }
            if self.userInformationDictionary[kParamKeyGender] {
                gender = self.userInformationDictionary[kParamKeyGender]
            }
            if self.userInformationDictionary[kParamKeyFirstname] {
                firstName = self.userInformationDictionary[kParamKeyFirstname]
            }
            if self.userInformationDictionary[kParamKeyLastname] {
                lastName = self.userInformationDictionary[kParamKeyLastname]
            }
            if self.userInformationDictionary[kParamKeyUserID] {
                userId = self.userInformationDictionary[kParamKeyUserID]
            }
            if self.userInformationDictionary[kParamKeyUserFirstKnoxTID] {
                if !(self.userInformationDictionary[kParamKeyUserFirstKnoxTID] is NSNull) {
                    userKnoxFirstTransactionID = self.userInformationDictionary[kParamKeyUserFirstKnoxTID]
                }
                else {
                    userKnoxFirstTransactionID = ""
                }
            }
            else {
                userKnoxFirstTransactionID = ""
            }
            if self.userInformationDictionary[kParamKeyUserKnoxTokenKey] {
                userKnoxTokenPassKey = self.userInformationDictionary[kParamKeyUserKnoxTokenKey]
            }
            if self.userInformationDictionary[kParamKeyUserKnoxTokenPassword] {
                userKnoxTokenPassword = self.userInformationDictionary[kParamKeyUserKnoxTokenPassword]
            }
            if self.userInformationDictionary[kParamKeyAmount] {
                if self.userInformationDictionary[kParamKeyAmount][kParamKeySaving] {
                    savingsAmount = Int(CInt(self.userInformationDictionary[kParamKeyAmount][kParamKeySaving]))
                }
                if self.userInformationDictionary[kParamKeyAmount][kParamKeyDeposit] {
                    depositsAmount = Int(CInt(self.userInformationDictionary[kParamKeyAmount][kParamKeyDeposit]))
                }
            }
            if self.userInformationDictionary[kParamKeyMissionCount] {
                if self.userInformationDictionary[kParamKeyMissionCount][kParamKeyActive] && self.userInformationDictionary[kParamKeyMissionCount][kParamKeyActive] != nil {
                    activeMissionsCount = Int(CInt(self.userInformationDictionary[kParamKeyMissionCount][kParamKeyActive]))
                }
                if self.userInformationDictionary[kParamKeyMissionCount][kParamKeyPending] && self.userInformationDictionary[kParamKeyMissionCount][kParamKeyPending] != nil {
                    pendingMissionsCount = Int(CInt(self.userInformationDictionary[kParamKeyMissionCount][kParamKeyPending]))
                }
                if self.userInformationDictionary[kParamKeyMissionCount][kParamKeyCompleted] && self.userInformationDictionary[kParamKeyMissionCount][kParamKeyCompleted] != nil {
                    completedMissionsCount = Int(CInt(self.userInformationDictionary[kParamKeyMissionCount][kParamKeyCompleted]))
                }
            }
            if self.userInformationDictionary[kParamKeyUserType] {
                if CInt(self.userInformationDictionary[kParamKeyUserType]) == .parentuser {
                    userIdentity = .parentuser
                }
                if CInt(self.userInformationDictionary[kParamKeyUserType]) == .childuser {
                    userIdentity = .childuser
                }
            }
            if self.userInformationDictionary[kParamKeyAvatar] {
                avatarUrlString = self.userInformationDictionary[kParamKeyAvatar]
            }
            if self.userInformationDictionary[kParamKeyBadgeDetails] {
                childBadgeDetailsArray = self.userInformationDictionary[kParamKeyBadgeDetails]
            }
        }
    }
    var isUserUnderAge: Bool = false
    var accessToken: String {
        get {
            // TODO: add getter implementation
        }
        set(accessToken) {
            self.accessToken = accessToken
        }
    }
    var dateOfBirth: String {
        get {
            // TODO: add getter implementation
        }
        set(dateOfBirth) {
            self.dateOfBirth = dateOfBirth
        }
    }
    var country: String {
        get {
            // TODO: add getter implementation
        }
        set(country) {
            self.country = country
        }
    }
    var emailAddress: String {
        get {
            // TODO: add getter implementation
        }
        set(emailAddress) {
            self.emailAddress = emailAddress
        }
    }
    var firstName: String {
        get {
            // TODO: add getter implementation
        }
        set(firstName) {
            self.firstName = firstName
        }
    }
    var lastName: String {
        get {
            // TODO: add getter implementation
        }
        set(lastName) {
            self.lastName = lastName
        }
    }
    var gender: String = ""
    var username: String {
        get {
            // TODO: add getter implementation
        }
        set(username) {
            self.username = username
        }
    }
    var password: String {
        get {
            // TODO: add getter implementation
        }
        set(password) {
            self.password = password
        }
    }
    var userId: String = ""
    var activeMissionsCount: NSNumber? {
        get {
            // TODO: add getter implementation
        }
        set(activeMissionsCount) {
            self.activeMissionsCount = activeMissionsCount
        }
    }
    var pendingMissionsCount: NSNumber? {
        get {
            // TODO: add getter implementation
        }
        set(pendingMissionsCount) {
            self.pendingMissionsCount = pendingMissionsCount
        }
    }
    var completedMissionsCount: NSNumber? {
        get {
            // TODO: add getter implementation
        }
        set(completedMissionsCount) {
            self.completedMissionsCount = completedMissionsCount
        }
    }
    var savingsAmount: NSNumber? {
        get {
            // TODO: add getter implementation
        }
        set(savingsAmount) {
            self.savingsAmount = savingsAmount
        }
    }
    var depositsAmount: NSNumber? {
        get {
            // TODO: add getter implementation
        }
        set(depositsAmount) {
            self.depositsAmount = depositsAmount
        }
    }
    var avatarUrlString: String {
        get {
            // TODO: add getter implementation
        }
        set(avatarUrlString) {
            self.avatarUrlString = avatarUrlString
        }
    }
    var childBadgeDetailsArray: [Any] {
        get {
            // TODO: add getter implementation
        }
        set(childBadgeDetailsArray) {
            self.childBadgeDetailsArray = childBadgeDetailsArray
        }
    }
    var userKnoxFirstTransactionID: String {
        get {
            // TODO: add getter implementation
        }
        set(userKnoxFirstTransactionID) {
            self.userKnoxFirstTransactionID = userKnoxFirstTransactionID
        }
    }
    var userKnoxTokenPassKey: String {
        get {
            // TODO: add getter implementation
        }
        set(userKnoxTokenPassKey) {
            self.userKnoxTokenPassKey = userKnoxTokenPassKey
        }
    }
    var userKnoxTokenPassword: String {
        get {
            // TODO: add getter implementation
        }
        set(userKnoxTokenPassword) {
            self.userKnoxTokenPassword = userKnoxTokenPassword
        }
    }
    var userDeviceToken: String {
        get {
            // TODO: add getter implementation
        }
        set(userDeviceToken) {
            self.userDeviceToken = userDeviceToken
        }
    }

    class func sharedInstance() -> STUserIdentity {
        let lockQueue = DispatchQueue(label: "self")
        lockQueue.sync {
            if __instance == nil {
                __instance = STUserIdentity()
                __instance.accessToken = STASHER_ACCESS_TOKEN
                if UserDefaults.standard.object(forKey: kUserDefaultsUserType) != nil {
                    if CInt(UserDefaults.standard.object(forKey: kUserDefaultsUserType)) == 3 {
                        __instance.userIdentity = .childuser
                    }
                    if CInt(UserDefaults.standard.object(forKey: kUserDefaultsUserType)) == 4 {
                        __instance.userIdentity = .parentuser
                    }
                }
                if UserDefaults.standard.object(forKey: kUserDefaultsUserFirstName) != nil {
                    __instance.firstName = UserDefaults.standard.object(forKey: kUserDefaultsUserFirstName)
                }
                if UserDefaults.standard.object(forKey: kUserDefaultsUserLastName) != nil {
                    __instance.lastName = UserDefaults.standard.object(forKey: kUserDefaultsUserLastName)
                }
                if UserDefaults.standard.object(forKey: kUserDefaultsLoggedInusername) != nil {
                    __instance.username = UserDefaults.standard.object(forKey: kUserDefaultsLoggedInusername)
                }
                if UserDefaults.standard.object(forKey: kUserDefaultsUserId) != nil {
                    __instance.userId = UserDefaults.standard.object(forKey: kUserDefaultsUserId)
                }
            }
            return __instance
        }
    }

    func setUserIdentityFieldsFromDictionary(_ dictionary: [AnyHashable: Any]) {
    }

    func flushUserInfoIdentity() {
        isUserUnderAge = false
        country = ""
        dateOfBirth = ""
        emailAddress = ""
        firstName = ""
        lastName = ""
        username = ""
        password = ""
        userInformationDictionary = nil
        userIdentity = .dummy
        userId = ""
        avatarUrlString = ""
        childBadgeDetailsArray = nil
        userKnoxFirstTransactionID = ""
    }

    func getChildrenArray() -> [Any] {
        var data = STCacheManager.sharedInstance().getJSONData(forAPIName: kAPIActionProfile)
        if data != nil {
            var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: data, options: kNilOptions)
            if responseDictionary != nil {
                if responseDictionary?[kParamKeyChild] {
                    if (responseDictionary?[kParamKeyChild] is [Any]) {
                        return responseDictionary?[kParamKeyChild]
                    }
                }
            }
        }
        return nil
    }

    func getParentsArray() -> [Any] {
        var data = STCacheManager.sharedInstance().getJSONData(forAPIName: kAPIActionProfile)
        if data != nil {
            var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: data, options: kNilOptions)
            if responseDictionary != nil {
                if responseDictionary?[kParamKeyParent] {
                    if (responseDictionary?[kParamKeyParent] is [Any]) {
                        return responseDictionary?[kParamKeyParent]
                    }
                }
            }
        }
        return nil
    }

    func shouldShowTutorials() -> Bool {
        if UserDefaults.standard.object(forKey: userId) == nil {
            UserDefaults.standard.set("YES", forKey: userId)
            UserDefaults.standard.synchronize()
            return true
        }
        return false
    }

    func shouldShowBadgeAlert() -> Bool {
        if UserDefaults.standard.object(forKey: kNSUDShowFirstBadgeAlert) == nil {
            UserDefaults.standard.set("YES", forKey: kNSUDShowFirstBadgeAlert)
            UserDefaults.standard.synchronize()
            return true
        }
        return false
    }


    func setIsUserUnderAge(_ isUserUnderAge: Bool) {
        self.isUserUnderAge = isUserUnderAge
    }
}
var __instance: STUserIdentity? = nil