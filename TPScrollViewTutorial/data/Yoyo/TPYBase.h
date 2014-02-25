//
//  TPYBase.h
//
//  Created by Philip Starner on 2/24/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TPYBase : NSObject <NSCoding>

@property (nonatomic, strong) NSArray *yoyo;

+ (TPYBase *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
