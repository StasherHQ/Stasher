//
//  BOABHttpReq.h
//  BOABHTTPReq
//
//  Created by bhushan on 06/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STActivityIndicatorView.h"
#import "BOABURLConnection.h"
#import "BOABMutableURLRequest.h"
#import "STNoInternetView.h"

@protocol BOABHttpReqDelegate <NSObject>

@optional

- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn;
- (void)BOABHttpReqFailedWithError:(NSError*)error;

@end


@interface BOABHttpReq : NSObject
{
    STActivityIndicatorView *activityIndicatorView;
}

@property (weak) id<BOABHttpReqDelegate> delegate;
@property (nonatomic, strong) NSDictionary* userInfo;
@property (nonatomic, strong) STActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) STNoInternetView *noInternetView;

- (id)initBoabReqWithDelegate:(id)del shouldShowActivityIndicatorView:(BOOL)showActivityIndicator;
- (void)sendAsyncGetRequest:(NSString *)url params:(NSDictionary *)params block:(void (^)(id, NSData *, NSError *))block statusBlock:(void (^)(NSString *))statusBlock;
- (void)sendAsyncPostRequest:(NSString *)url params:(NSDictionary *)params json:(BOOL)json block:(void (^)(id, NSData *, NSError *))block statusBlock:(void (^)(NSString *))statusBlock;
- (void)sendAsyncPostRequest:(NSString*)url params:(NSDictionary*)params json:(BOOL)json ;
- (void)sendAsyncGetRequest:(NSString *)url params:(NSDictionary *)params;
- (void)sendAsyncGetRequest:(NSString *)url;
- (BOOL)reachable;
- (void)cancel;


@end
