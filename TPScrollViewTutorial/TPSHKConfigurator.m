//
//  TPSHKConfigurator.m
//  TPScrollViewTutorial
//
//  Created by Philip Starner on 3/13/14.
//  Copyright (c) 2014 Philip Starner. All rights reserved.
//

#import "TPSHKConfigurator.h"

@implementation TPSHKConfigurator


- (NSString*)appName {
	return @"Share Kit Demo App";
}

- (NSString*)appURL {
	return @"https://github.com/ShareKit/ShareKit/";
}

- (NSString*)facebookAppId {
	return @"232705466797125"; //test
}

- (NSString*)facebookLocalAppId {
	return @"";
}

- (NSNumber*)forcePreIOS5TwitterAccess {
    return [NSNumber numberWithBool:false];
}

- (NSString*)twitterConsumerKey {
	return @"48Ii81VO5NtDKIsQDZ3Ggw";
}

- (NSString*)twitterSecret {
	return @"WYc2HSatOQGXlUCsYnuW3UjrlqQj0xvkvvOIsKek32g";
}
// You need to set this if using OAuth, see note above (xAuth users can skip it)
- (NSString*)twitterCallbackUrl {
	return @"http://twitter.sharekit.com";
}
// To use xAuth, set to 1
- (NSNumber*)twitterUseXAuth {
	return [NSNumber numberWithInt:0];
}
// Enter your app's twitter account if you'd like to ask the user to follow it when logging in. (Only for xAuth)
- (NSString*)twitterUsername {
	return @"";
}

- (NSNumber *)useAppleShareUI {
    return @YES;
}

- (UIColor*)barTintForView:(UIViewController*)vc {
	
    if ([NSStringFromClass([vc class]) isEqualToString:@"SHKTwitter"])
        return [UIColor colorWithRed:0 green:151.0f/255 blue:222.0f/255 alpha:1];
    
    if ([NSStringFromClass([vc class]) isEqualToString:@"SHKFacebook"])
        return [UIColor colorWithRed:59.0f/255 green:89.0f/255 blue:152.0f/255 alpha:1];
    
    return nil;
}

@end
