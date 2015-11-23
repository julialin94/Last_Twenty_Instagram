//
//  JLAccessTokenManager.m
//  Last_Twenty_Instagram
//
//  Created by Julia Lin on 11/19/15.
//  Copyright © 2015 Julia Lin. All rights reserved.
//

#import "LTIAccessTokenManager.h"
#import <KeychainItemWrapper/KeychainItemWrapper.h>

@implementation LTIAccessTokenManager

+(KeychainItemWrapper *)keychain {
    static KeychainItemWrapper * keychain = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"lti_keychain" accessGroup:nil];
    });
    return keychain;
}

+(NSString *)accessToken {
    NSString * accessToken = [[self keychain] objectForKey:(NSString *)kSecValueData];
    return accessToken.length == 0 ? nil : accessToken;
}

+(void)setAccessToken:(NSString *)url {
    NSString *access_token;
    NSRange access_token_range = [url rangeOfString:@"access_token="];
    if (access_token_range.length > 0) {
        NSUInteger from_index = access_token_range.location + access_token_range.length;
        access_token = [url substringFromIndex:from_index];
    }
    [[self keychain] setObject:access_token forKey:(NSString *)kSecValueData];
}

@end
