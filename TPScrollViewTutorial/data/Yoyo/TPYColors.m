//
//  TPYColors.m
//
//  Created by Philip Starner on 2/24/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "TPYColors.h"


NSString *const kTPYColorsName = @"name";
NSString *const kTPYColorsHex = @"hex";


@interface TPYColors ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TPYColors

@synthesize name = _name;
@synthesize hex = _hex;


+ (TPYColors *)modelObjectWithDictionary:(NSDictionary *)dict
{
    TPYColors *instance = [[TPYColors alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.name = [self objectOrNilForKey:kTPYColorsName fromDictionary:dict];
            self.hex = [self objectOrNilForKey:kTPYColorsHex fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kTPYColorsName];
    [mutableDict setValue:self.hex forKey:kTPYColorsHex];

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

    self.name = [aDecoder decodeObjectForKey:kTPYColorsName];
    self.hex = [aDecoder decodeObjectForKey:kTPYColorsHex];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kTPYColorsName];
    [aCoder encodeObject:_hex forKey:kTPYColorsHex];
}


@end
