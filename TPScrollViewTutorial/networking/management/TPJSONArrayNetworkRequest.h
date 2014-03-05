//
//  TPJSONArrayNetworkRequest.h
//  TPScrollViewTutorial
//
//  Created by Philip Starner on 2/27/14.
//  Copyright (c) 2014 Philip Starner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPJSONArrayNetworkRequest : NSObject

+ (TPJSONArrayNetworkRequest *) sharedInstance;

- (void) loadLocalJSON:(void (^)(NSString* JSONString))handler;
- (void) loadOnlineJSON:(void (^)(NSObject* JSONData))handler;
@end
