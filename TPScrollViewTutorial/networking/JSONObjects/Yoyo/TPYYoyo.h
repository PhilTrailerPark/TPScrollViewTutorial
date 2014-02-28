//
//  TPYYoyo.h
//
//  Created by Philip Starner on 2/24/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TPYImage, TPYMaterial;

@interface TPYYoyo : NSObject <NSCoding>

@property (nonatomic, strong) NSString *yoyoDescription;
@property (nonatomic, strong) NSString *bearing;
@property (nonatomic, strong) NSString *competitions;
@property (nonatomic, assign) double diameter;
@property (nonatomic, assign) double weight;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) TPYImage *image;
@property (nonatomic, strong) NSString *manufacturer;
@property (nonatomic, assign) double year;
@property (nonatomic, strong) NSString *player;
@property (nonatomic, strong) NSString *response;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) TPYMaterial *material;

+ (TPYYoyo *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
