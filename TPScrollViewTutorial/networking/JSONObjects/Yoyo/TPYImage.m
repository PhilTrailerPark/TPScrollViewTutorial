//
//  TPYImage.m
//
//  Created by Philip Starner on 2/24/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "TPYImage.h"


NSString *const kTPYImageSmall = @"small";
NSString *const kTPYImageLarge = @"large";
NSString *const kTPYImageMedium = @"medium";


@interface TPYImage ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TPYImage

@synthesize small = _small;
@synthesize large = _large;
@synthesize medium = _medium;


+ (TPYImage *)modelObjectWithDictionary:(NSDictionary *)dict
{
    TPYImage *instance = [[TPYImage alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.small = [self objectOrNilForKey:kTPYImageSmall fromDictionary:dict];
            self.large = [self objectOrNilForKey:kTPYImageLarge fromDictionary:dict];
            self.medium = [self objectOrNilForKey:kTPYImageMedium fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.small forKey:kTPYImageSmall];
    [mutableDict setValue:self.large forKey:kTPYImageLarge];
    [mutableDict setValue:self.medium forKey:kTPYImageMedium];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.small = [aDecoder decodeObjectForKey:kTPYImageSmall];
    self.large = [aDecoder decodeObjectForKey:kTPYImageLarge];
    self.medium = [aDecoder decodeObjectForKey:kTPYImageMedium];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_small forKey:kTPYImageSmall];
    [aCoder encodeObject:_large forKey:kTPYImageLarge];
    [aCoder encodeObject:_medium forKey:kTPYImageMedium];
}


@end
