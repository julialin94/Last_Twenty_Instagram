//
//  JLAccessTokenManager.m
//  Last_Twenty_Instagram
//
//  Created by Julia Lin on 11/19/15.
//  Copyright © 2015 Julia Lin. All rights reserved.
//

#import "LTIAccessTokenManager.h"

@implementation LTIAccessTokenManager

+(NSString *)accessToken {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"access_token"];
}

#warning Note: Storing Access Token in NSUserDefaults potentially unsafe
+(void)setAccessToken:(NSString *)url {
    NSString *access_token;
    NSRange access_token_range = [url rangeOfString:@"access_token="];
    if (access_token_range.length > 0) {
        NSUInteger from_index = access_token_range.location + access_token_range.length;
        access_token = [url substringFromIndex:from_index];
        NSLog(@"access_token:  %@", access_token);
    }
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:access_token forKey:@"access_token"];
    [defaults synchronize];
}

@end
