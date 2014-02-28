//
//  TPJSONArrayNetworkRequest.m
//  TPScrollViewTutorial
//
//  Created by Philip Starner on 2/27/14.
//  Copyright (c) 2014 Philip Starner. All rights reserved.
//

#import "TPJSONArrayNetworkRequest.h"

static TPJSONArrayNetworkRequest *instance;

@implementation TPJSONArrayNetworkRequest

#pragma mark singleton

+ (TPJSONArrayNetworkRequest *) sharedInstance {
    if(!instance) {
        instance = [[TPJSONArrayNetworkRequest alloc] init];
    }
    return instance;
}

- (void) loadLocalJSON {
    NSString* filepath = [[NSBundle mainBundle]pathForResource:@"yoyo" ofType:@"json"];
    
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
    
    self.yoyoBase = [[TPYBase alloc] initWithDictionary:[jsonString objectFromJSONString]];
    
    [self.tableView reloadData];
}

- (void) loadOnlineJSON {
    
    NSString *yoyoUrl = [NSString stringWithFormat:@"%@popcorn/yoyo.json", BaseURLString];
    NSURL *url = [NSURL URLWithString:yoyoUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.yoyoBase = [[TPYBase alloc] initWithDictionary:responseObject];
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving YoYos" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [av show];
    }];
    
    [operation start];
    
}


@end
