//
//  JLAccessTokenManager.h
//  Last_Twenty_Instagram
//
//  Created by Julia Lin on 11/19/15.
//  Copyright © 2015 Julia Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTIAccessTokenManager : NSObject

+(NSString *)accessToken;
+(void)setAccessToken:(NSString *)url;

@end
