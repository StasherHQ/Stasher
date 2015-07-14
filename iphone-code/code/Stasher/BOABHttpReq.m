//
//  BOABHttpReq.m
//  BOABHTTPReq
//
//  Created by bhushan on 06/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "BOABHttpReq.h"
#import <UIKit/UIKit.h>


@interface BOABHttpReq ()

@property (nonatomic) BOABURLConnection *conn;
@property (nonatomic) NSMutableData *data;
@property (nonatomic, copy) void (^block)(id, NSData *, NSError *);
@property (nonatomic, copy) void (^statusBlock)(NSString *);
@end

@implementation BOABHttpReq
@synthesize delegate;
@synthesize userInfo;
@synthesize activityIndicatorView;

- (id)initBoabReqWithDelegate:(id)del shouldShowActivityIndicatorView:(BOOL)showActivityIndicator
{
    self = [super init];
    if (self) {
        self.data = [NSMutableData data];
        self.delegate = del;
        if (showActivityIndicator) {
            UIViewController *vc = (UIViewController*)del;
            self.activityIndicatorView = [[STActivityIndicatorView alloc] initWithDefaultSizeandSuperView:vc.view];
            [vc.view setUserInteractionEnabled:YES];
        }
    }
    return  self;
}

- (void) initializeRequest:(void (^)(id, NSData *, NSError *))block
               statusBlock:(void (^)(NSString *))statusBlock
{
    self.data = [NSMutableData data];
    self.block = block;
    self.statusBlock = statusBlock;
}

- (NSData *)getJsonEncodedParams:(NSDictionary *)params
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
    if (error)
        NSLog(@"%@",error);
    return jsonData;
}

- (NSData *)getEncodedParams:(NSDictionary *)params json:(BOOL)json
{
    NSData *paramsAsData;
    if (json) {
        paramsAsData = [self getJsonEncodedParams:params];
    } else {
        NSString *paramsAsString = [self getUrlEncodedParams:params];
        paramsAsData = [paramsAsString dataUsingEncoding:NSUTF8StringEncoding];
    }
    return paramsAsData;
}

- (void)setContentType:(BOABMutableURLRequest *)req json:(BOOL)json
{
    if (json) {
        [req setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        //[req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
}

- (void)sendAsyncPostRequest:(NSString *)url
                      params:(NSDictionary *)params
                        json:(BOOL)json
                       block:(void (^)(id, NSData *, NSError *))block
                 statusBlock:(void (^)(NSString *))statusBlock
{
    if ([self reachable]) {
        self.userInfo = params;
        [self.activityIndicatorView startAnimation];
        [self initializeRequest:block statusBlock:statusBlock];
        
        BOABMutableURLRequest *req = [BOABMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [self setContentType:req json:json];
        [req setHTTPMethod:@"POST"];
        NSMutableDictionary *muParamsDict = [params mutableCopy];
        [muParamsDict setObject:[[STUserIdentity sharedInstance] accessToken] forKey:kParamKeyAccessToken];
        NSMutableArray *pairs = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSString *key in muParamsDict) {
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, muParamsDict[key]]];
        }
        /* We finally join the pairs of our array
         using the '&' */
        NSString *postString = [pairs componentsJoinedByString:@"&"];
        //NSLog(@"The POST body - %@",postString);
        [req setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postString.length] forHTTPHeaderField:@"Content-length"];
        [req setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        
        [self connect:req];
    }
}

- (void)sendStatusUpdate:(NSString *)message
{
    if (!self.statusBlock || self.statusBlock == NULL)
        return;
    self.statusBlock(message);
}

- (void) connect:(BOABMutableURLRequest *)request
{
    BOABURLConnection *conn = [[BOABURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    if (!conn) {
        if (self.block) {
            self.block(nil, nil, [NSError errorWithDomain:@"" code:1 userInfo:nil]);
        }
        if ([self.delegate respondsToSelector:@selector(BOABHttpReqFailedWithError:)]) {
            [self.delegate BOABHttpReqFailedWithError:[NSError errorWithDomain:@"" code:1 userInfo:nil]];
        }
        
        [UIAlertView showWithTitle:@""
                           message:@"Stasher has some network issues! Try Later."
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                              }
                          }];
        
        return;
    }
    self.conn = conn;
    self.conn.userInfo = request.userInfo;
    [conn start];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self sendStatusUpdate:@"Connecting..."];
}

- (NSString *) getUrlEncodedParams:(NSDictionary *)params
{
    NSMutableString *paramsAsString = [NSMutableString string];
    BOOL firstParam = YES;
    for (NSString *key in params.allKeys) {
        id value = [params valueForKey:key];
        NSData *valueAsData = [NSJSONSerialization dataWithJSONObject:value options:0 error:NULL];
        value = [[NSString alloc] initWithData:valueAsData encoding:NSUTF8StringEncoding];
        if (firstParam) {
            firstParam = NO;
        } else {
            [paramsAsString appendString:@"&"];
        }
        [paramsAsString appendString:[NSString stringWithFormat:@"%@=%@",key,[self getEscapedString:value]]];
    }
    
    return paramsAsString;
}

- (NSString *) getEscapedString:(NSString *)unescapedString
{
    if (![unescapedString isKindOfClass:[NSString class]]) {
        return unescapedString;
    }
    NSString *escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (CFStringRef)unescapedString,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8 ));
    return escapedString;
}

- (void)sendAsyncGetRequest:(NSString *)url
                     params:(NSDictionary *)params
                      block:(void (^)(id, NSData *, NSError *))block
                statusBlock:(void (^)(NSString *))statusBlock
{
    if ([self reachable]) {
        self.userInfo = params;
        [self.activityIndicatorView startAnimation];
        [self initializeRequest:block statusBlock:statusBlock];
        NSString *paramsAsString = [self getUrlEncodedParams:params];
        
        [self sendStatusUpdate:[NSString stringWithFormat:@"PARAMS - %@", paramsAsString]];
        url = [NSString stringWithFormat:@"%@?%@",url,paramsAsString];
        [self sendStatusUpdate:[NSString stringWithFormat:@"URL - %@", url]];
        BOABMutableURLRequest *req = [BOABMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [self connect:req];
    }
}


#pragma mark - RequestUsingDelegate

- (void)sendAsyncPostRequest:(NSString*)url params:(NSDictionary*)params json:(BOOL)json
{
    if ([self reachable]) {
        [self.activityIndicatorView startAnimation];
        BOABMutableURLRequest *req = [BOABMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [self setContentType:req json:json];
        [req setHTTPMethod:@"POST"];
        self.userInfo = params;
        NSMutableDictionary *muParamsDict = [params mutableCopy];
        [muParamsDict setObject:[[STUserIdentity sharedInstance] accessToken] forKey:@"accesstoken"];
        
        NSMutableArray *pairs = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSString *key in muParamsDict) {
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, muParamsDict[key]]];
        }
        /* We finally join the pairs of our array
         using the '&' */
        NSString *postString = [pairs componentsJoinedByString:@"&"];
        //NSLog(@"The POST body - %@",postString);
        [req setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postString.length] forHTTPHeaderField:@"Content-length"];
        [req setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        req.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:url,@"url", req, @"request",muParamsDict,@"params",nil];
        [self connect:req];
        
        NSLog(@"Request URL = %@ \n Request body %@", req.URL,[[NSString alloc] initWithData:[req HTTPBody] encoding:NSUTF8StringEncoding]);
    }else{
        [UIAlertView showWithTitle:@""
                           message:@"Stasher has some network issues! Try Later."
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                              }
                          }];
    }
}

- (void)sendAsyncGetRequest:(NSString *)url params:(NSDictionary *)params
{
    if ([self reachable]) {
        [self.activityIndicatorView startAnimation];
        NSString *paramsAsString = [self getUrlEncodedParams:params];
        self.userInfo = params;
        [self sendStatusUpdate:[NSString stringWithFormat:@"PARAMS - %@", paramsAsString]];
        url = [NSString stringWithFormat:@"%@?%@",url,paramsAsString];
        [self sendStatusUpdate:[NSString stringWithFormat:@"URL - %@", url]];
        BOABMutableURLRequest *req = [BOABMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        [self connect:req];
    }
}

- (void)sendAsyncGetRequest:(NSString *)url
{
    if ([self reachable]) {
        [self.activityIndicatorView startAnimation];
        url = [NSString stringWithFormat:@"%@",url];
        [self sendStatusUpdate:[NSString stringWithFormat:@"URL - %@", url]];
        BOABMutableURLRequest *req = [BOABMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        [self connect:req];
    }
}

#pragma mark - Connection Delegate


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIViewController *vc = (UIViewController*)self.delegate;
    [vc.view setUserInteractionEnabled:YES];
    [self.activityIndicatorView stopAnimation];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (self.block)
        self.block(nil, nil, error);
    if ([self.delegate respondsToSelector:@selector(BOABHttpReqFailedWithError:)]) {
        [self.delegate BOABHttpReqFailedWithError:error];
        if (self.noInternetView) {
            [self.noInternetView removeFromSuperview];
            self.noInternetView = nil;
        }
        UIViewController *vc = (UIViewController*)self.delegate;
        self.noInternetView = [[STNoInternetView alloc] initWithDefaultSizeandSuperView:vc.view];
        if ([vc isKindOfClass:NSClassFromString(@"STParentPaymentViewController")]) {
            [self.noInternetView setFrame:CGRectMake(0.0f, vc.view.frame.size.height - 30.0f, vc.view.frame.size.width, 30.0f)];
        }
    }
    BOOL showErrorAlert = TRUE;
    if (self.userInfo) {
        if ([[self.userInfo objectForKey:@"action"] isEqualToString:kAPIActionSearchChild]) {
            showErrorAlert = FALSE;
        }
        else if ([self reachable]){
            showErrorAlert = FALSE;
        }
    }
    if (showErrorAlert) {
        [UIAlertView showWithTitle:@""
                           message:@"Stasher has some network issues! Try Later."
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                              }
                          }];
    }
    [self sendStatusUpdate:error.description];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIViewController *vc = (UIViewController*)self.delegate;
    [vc.view setUserInteractionEnabled:YES];
    [self.activityIndicatorView stopAnimation];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (self.block) {
        NSError *error;
        id data = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:&error];
        self.block(data, self.data, error);
    } else {
        [self sendStatusUpdate:@"Finished downloading data"];
    }
    
    if ([self.delegate respondsToSelector:@selector(BOABHttpReqFinishedWithResponse:andConnection:)]) {
        [self.delegate BOABHttpReqFinishedWithResponse:self.data andConnection:(BOABURLConnection*)connection];
        
        if (self.userInfo) {
            if ([[self.userInfo objectForKey:kParamKeySaveResponseLocally] isEqualToString:@"yes"]) {
                if ([[self.userInfo objectForKey:@"action"] isEqualToString:kAPIActionProfile] ){
                    NSString *filePath = [NSString stringWithFormat:@"%@.%@",[[STCacheManager sharedInstance] applicationCachedJSONDirectory],@"txt"];
                    NSError *err= nil;
                    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&err];
                    }
                    NSString *jsonString = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
                    [[STCacheManager sharedInstance] saveJSONForAPIName:[self.userInfo objectForKey:@"action"] JSONString:jsonString];
                    jsonString = nil;
                    filePath = nil;
                }
            }
        }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger code = [httpResponse statusCode];
    if (code != 200) {
        if(self.block)
            self.block(nil, nil, [[NSError alloc] initWithDomain:@"HTTPError" code:code userInfo:@{}]);
        if ([self.delegate respondsToSelector:@selector(BOABHttpReqFailedWithError:)]) {
            [self.delegate BOABHttpReqFailedWithError:[[NSError alloc] initWithDomain:@"HTTPError" code:code userInfo:@{}]];
        }
        
        [UIAlertView showWithTitle:@""
                           message:@"Stasher has some network issues! Try Later."
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                              }
                          }];
        
        [self cancel];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
    [self sendStatusUpdate:[NSString stringWithFormat:@"Got %lu bytes", (unsigned long)self.data.length]];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    UIViewController *vc = (UIViewController*)self.delegate;
    [vc.view setUserInteractionEnabled:YES];
    [self.activityIndicatorView stopAnimation];
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    [self sendStatusUpdate:@"Got auth challenge"];
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        [self sendStatusUpdate:@"Ignoring SSL"];
        SecTrustRef trust = challenge.protectionSpace.serverTrust;
        NSURLCredential *cred = [NSURLCredential credentialForTrust:trust];
        [challenge.sender useCredential:cred forAuthenticationChallenge:challenge];
        return;
    }
    [self sendStatusUpdate:@"Cancelling SSL"];
    [[challenge sender] cancelAuthenticationChallenge:challenge];
}

- (void)cancel
{
    UIViewController *vc = (UIViewController*)self.delegate;
    [vc.view setUserInteractionEnabled:YES];
    [self.activityIndicatorView stopAnimation];
    self.block = nil;
    self.data = nil;
    [self.conn cancel];
    self.conn = nil;
}

#pragma mark - Rechability
- (BOOL)reachable
{
    Reachability *hostReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [hostReach currentReachabilityStatus];
    
    Reachability *reachable = [Reachability reachabilityWithHostName:kREACHABILITYCHECKURL];
    NetworkStatus netHostStatus = [reachable currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        /*
        [UIAlertView showWithTitle:@""
                           message:@"Looks like network issue! Try later."
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                              }
                          }];
         */
        if (self.noInternetView) {
            [self.noInternetView removeFromSuperview];
            self.noInternetView = nil;
        }
        UIViewController *vc = (UIViewController*)self.delegate;
        self.noInternetView = [[STNoInternetView alloc] initWithDefaultSizeandSuperView:vc.view];
        if ([vc isKindOfClass:NSClassFromString(@"STParentPaymentViewController")]) {
            [self.noInternetView setFrame:CGRectMake(0.0f, vc.view.frame.size.height - 30.0f, vc.view.frame.size.width, 30.0f)];
        }
        return NO;
    }
    else if(netHostStatus == NotReachable)
    {
        /*
        [UIAlertView showWithTitle:@""
                           message:@"Looks like network issue! Try later."
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                              }
                          }];
         */
        if (self.noInternetView) {
            [self.noInternetView removeFromSuperview];
            self.noInternetView = nil;
        }
        UIViewController *vc = (UIViewController*)self.delegate;
        self.noInternetView = [[STNoInternetView alloc] initWithDefaultSizeandSuperView:vc.view];
        if ([vc isKindOfClass:NSClassFromString(@"STParentPaymentViewController")]) {
            [self.noInternetView setFrame:CGRectMake(0.0f, vc.view.frame.size.height - 30.0f, vc.view.frame.size.width, 30.0f)];
        }
        return NO;
    }
    return YES;
}



@end
