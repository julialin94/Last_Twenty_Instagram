//
//  JLAPIManager.h
//  Last_Twenty_Instagram
//
//  Created by Julia Lin on 11/19/15.
//  Copyright © 2015 Julia Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "LTIConstants.h"

@interface LTIAPIManager : AFHTTPRequestOperationManager
+(void)getSelfRecentMediaWithCount:(NSNumber *)count
                andCompletion:(completionHandler) completion;
@end

