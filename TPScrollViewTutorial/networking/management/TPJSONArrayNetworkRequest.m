//
//  TPJSONArrayNetworkRequest.m
//  TPScrollViewTutorial
//
//  Created by Philip Starner on 2/27/14.
//  Copyright (c) 2014 Philip Starner. All rights reserved.
//

#import "TPJSONArrayNetworkRequest.h"
#import "UIImageView+AFNetworking.h"
#import "AFHTTPRequestOperation.h"
#import "JSONKit.h"

static TPJSONArrayNetworkRequest *instance;

@implementation TPJSONArrayNetworkRequest

#pragma mark singleton

+ (TPJSONArrayNetworkRequest *) sharedInstance {
    if(!instance) {
        instance = [[TPJSONArrayNetworkRequest alloc] init];
    }
    return instance;
}

- (void) loadLocalJSON:(void (^)(NSString* JSONString))handler
{
    NSString* filepath = [[NSBundle mainBundle]pathForResource:@"yoyo" ofType:@"json"];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
    
    //TODO: verify the jsonString for valid JSON
    if(handler)
        handler(jsonString);
    
}

- (void) loadOnlineJSON:(void (^)(NSObject* JSONData))handler
{
    NSString *yoyoUrl = [NSString stringWithFormat:@"%@%@", BaseURLString, YoYoURLString];
    NSURL *url = [NSURL URLWithString:yoyoUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //TODO: verify the jsonString for valid JSON
        if(handler)
            handler(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(handler)
            handler(error);
    }];
    
    [operation start];
}


@end
