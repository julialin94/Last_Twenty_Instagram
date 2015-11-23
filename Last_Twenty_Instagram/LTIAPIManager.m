//
//  JLAPIManager.m
//  Last_Twenty_Instagram
//
//  Created by Julia Lin on 11/19/15.
//  Copyright © 2015 Julia Lin. All rights reserved.
//

#import "LTIAPIManager.h"
#import "LTIAccessTokenManager.h"


@implementation LTIAPIManager

+(void)getSelfRecentMediaWithCount:(NSNumber *)count andCompletion:(completionHandler)completion {
    
    NSDictionary * params = @{
                              @"access_token": [LTIAccessTokenManager accessToken],
                              @"count": count
                              };
    NSString * urlString = [NSString stringWithFormat:@"%@/users/self/media/recent", BASE_URL];
    [[LTIAPIManager sharedInstance] GET:urlString
                            parameters:params
                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                   if (completion) {
                                       completion(responseObject, nil);
                                   }
                                   
                               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                   NSLog(@"Error: %@", error.localizedDescription);
                                   if (completion) {
                                       completion(nil, error);
                                   }
                               }];
}

+(id)sharedInstance {
    static LTIAPIManager * sharedAPIManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAPIManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    });
    return sharedAPIManager;
}

@end
