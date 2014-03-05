//
//  TPScrollViewTutorialTests.m
//  TPScrollViewTutorialTests
//
//  Created by Philip Starner on 2/12/14.
//  Copyright (c) 2014 Philip Starner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TPJSONArrayNetworkRequest.h"
#import "TPJSONArrayNetworkRequest.h"
#include <objc/runtime.h>;

@interface TPScrollViewTutorialTests : XCTestCase

@end

@implementation TPScrollViewTutorialTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testJSON
{
    TPJSONArrayNetworkRequest *tpjson = [TPJSONArrayNetworkRequest sharedInstance];
    [tpjson loadOnlineJSON:^(NSObject *jsonData) {
    //[tpjson loadOnlineJSON:^NSObject *(NSObject *jsonData) {
        NSLog(@".........JSONData %@", jsonData);
        XCTAssertTrue(object_setClass(jsonData, [NSError class]), @"Checking to see if JSON is grabbed from: %@", BaseURLString);
    }];
    
    
    NSLog(@"Done");
    
}

@end
