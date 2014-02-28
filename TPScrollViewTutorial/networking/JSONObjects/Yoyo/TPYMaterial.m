//
//  TPYMaterial.m
//
//  Created by Philip Starner on 2/24/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "TPYMaterial.h"


NSString *const kTPYMaterialRims = @"rims";
NSString *const kTPYMaterialBody = @"body";


@interface TPYMaterial ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TPYMaterial

@synthesize rims = _rims;
@synthesize body = _body;


+ (TPYMaterial *)modelObjectWithDictionary:(NSDictionary *)dict
{
    TPYMaterial *instance = [[TPYMaterial alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.rims = [self objectOrNilForKey:kTPYMaterialRims fromDictionary:dict];
            self.body = [self objectOrNilForKey:kTPYMaterialBody fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.rims forKey:kTPYMaterialRims];
    [mutableDict setValue:self.body forKey:kTPYMaterialBody];

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

    self.rims = [aDecoder decodeObjectForKey:kTPYMaterialRims];
    self.body = [aDecoder decodeObjectForKey:kTPYMaterialBody];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_rims forKey:kTPYMaterialRims];
    [aCoder encodeObject:_body forKey:kTPYMaterialBody];
}


@end
