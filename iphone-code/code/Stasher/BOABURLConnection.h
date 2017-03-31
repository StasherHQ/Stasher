//
//  BOABURLConnection.h
//  BOABHTTPReq
//
//  Created by bhushan on 06/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BOABURLConnection : NSURLConnection
{
    NSDictionary *userInfo;
}
@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, strong) NSString* connID;
@end
