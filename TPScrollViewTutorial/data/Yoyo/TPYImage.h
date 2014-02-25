//
//  TPYImage.h
//
//  Created by Philip Starner on 2/24/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TPYImage : NSObject <NSCoding>

@property (nonatomic, strong) NSString *small;
@property (nonatomic, strong) NSString *large;
@property (nonatomic, strong) NSString *medium;

+ (TPYImage *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
