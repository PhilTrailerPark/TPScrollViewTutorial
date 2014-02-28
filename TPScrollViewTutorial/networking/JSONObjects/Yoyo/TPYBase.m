//
//  TPYBase.m
//
//  Created by Philip Starner on 2/24/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "TPYBase.h"
#import "TPYYoyo.h"


NSString *const kTPYBaseYoyo = @"yoyo";


@interface TPYBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TPYBase

@synthesize yoyo = _yoyo;


+ (TPYBase *)modelObjectWithDictionary:(NSDictionary *)dict
{
    TPYBase *instance = [[TPYBase alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedTPYYoyo = [dict objectForKey:kTPYBaseYoyo];
    NSMutableArray *parsedTPYYoyo = [NSMutableArray array];
    if ([receivedTPYYoyo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTPYYoyo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTPYYoyo addObject:[TPYYoyo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTPYYoyo isKindOfClass:[NSDictionary class]]) {
       [parsedTPYYoyo addObject:[TPYYoyo modelObjectWithDictionary:(NSDictionary *)receivedTPYYoyo]];
    }

    self.yoyo = [NSArray arrayWithArray:parsedTPYYoyo];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForYoyo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.yoyo) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForYoyo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForYoyo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForYoyo] forKey:@"kTPYBaseYoyo"];

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

    self.yoyo = [aDecoder decodeObjectForKey:kTPYBaseYoyo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_yoyo forKey:kTPYBaseYoyo];
}


@end
