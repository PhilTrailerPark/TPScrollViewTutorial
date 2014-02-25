//
//  TPYYoyo.m
//
//  Created by Philip Starner on 2/24/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "TPYYoyo.h"
#import "TPYColors.h"
#import "TPYImage.h"
#import "TPYMaterial.h"


NSString *const kTPYYoyoDescription = @"description";
NSString *const kTPYYoyoBearing = @"bearing";
NSString *const kTPYYoyoCompetitions = @"competitions";
NSString *const kTPYYoyoDiameter = @"diameter";
NSString *const kTPYYoyoWeight = @"weight";
NSString *const kTPYYoyoColors = @"colors";
NSString *const kTPYYoyoImage = @"image";
NSString *const kTPYYoyoManufacturer = @"manufacturer";
NSString *const kTPYYoyoYear = @"year";
NSString *const kTPYYoyoPlayer = @"player";
NSString *const kTPYYoyoResponse = @"response";
NSString *const kTPYYoyoCountry = @"country";
NSString *const kTPYYoyoName = @"name";
NSString *const kTPYYoyoMaterial = @"material";


@interface TPYYoyo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TPYYoyo

@synthesize yoyoDescription = _yoyoDescription;
@synthesize bearing = _bearing;
@synthesize competitions = _competitions;
@synthesize diameter = _diameter;
@synthesize weight = _weight;
@synthesize colors = _colors;
@synthesize image = _image;
@synthesize manufacturer = _manufacturer;
@synthesize year = _year;
@synthesize player = _player;
@synthesize response = _response;
@synthesize country = _country;
@synthesize name = _name;
@synthesize material = _material;


+ (TPYYoyo *)modelObjectWithDictionary:(NSDictionary *)dict
{
    TPYYoyo *instance = [[TPYYoyo alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.yoyoDescription = [self objectOrNilForKey:kTPYYoyoDescription fromDictionary:dict];
            self.bearing = [self objectOrNilForKey:kTPYYoyoBearing fromDictionary:dict];
            self.competitions = [self objectOrNilForKey:kTPYYoyoCompetitions fromDictionary:dict];
            self.diameter = [[self objectOrNilForKey:kTPYYoyoDiameter fromDictionary:dict] doubleValue];
            self.weight = [[self objectOrNilForKey:kTPYYoyoWeight fromDictionary:dict] doubleValue];
    NSObject *receivedTPYColors = [dict objectForKey:kTPYYoyoColors];
    NSMutableArray *parsedTPYColors = [NSMutableArray array];
    if ([receivedTPYColors isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTPYColors) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTPYColors addObject:[TPYColors modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTPYColors isKindOfClass:[NSDictionary class]]) {
       [parsedTPYColors addObject:[TPYColors modelObjectWithDictionary:(NSDictionary *)receivedTPYColors]];
    }

    self.colors = [NSArray arrayWithArray:parsedTPYColors];
            self.image = [TPYImage modelObjectWithDictionary:[dict objectForKey:kTPYYoyoImage]];
            self.manufacturer = [self objectOrNilForKey:kTPYYoyoManufacturer fromDictionary:dict];
            self.year = [[self objectOrNilForKey:kTPYYoyoYear fromDictionary:dict] doubleValue];
            self.player = [self objectOrNilForKey:kTPYYoyoPlayer fromDictionary:dict];
            self.response = [self objectOrNilForKey:kTPYYoyoResponse fromDictionary:dict];
            self.country = [self objectOrNilForKey:kTPYYoyoCountry fromDictionary:dict];
            self.name = [self objectOrNilForKey:kTPYYoyoName fromDictionary:dict];
            self.material = [TPYMaterial modelObjectWithDictionary:[dict objectForKey:kTPYYoyoMaterial]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.yoyoDescription forKey:kTPYYoyoDescription];
    [mutableDict setValue:self.bearing forKey:kTPYYoyoBearing];
    [mutableDict setValue:self.competitions forKey:kTPYYoyoCompetitions];
    [mutableDict setValue:[NSNumber numberWithDouble:self.diameter] forKey:kTPYYoyoDiameter];
    [mutableDict setValue:[NSNumber numberWithDouble:self.weight] forKey:kTPYYoyoWeight];
NSMutableArray *tempArrayForColors = [NSMutableArray array];
    for (NSObject *subArrayObject in self.colors) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForColors addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForColors addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForColors] forKey:@"kTPYYoyoColors"];
    [mutableDict setValue:[self.image dictionaryRepresentation] forKey:kTPYYoyoImage];
    [mutableDict setValue:self.manufacturer forKey:kTPYYoyoManufacturer];
    [mutableDict setValue:[NSNumber numberWithDouble:self.year] forKey:kTPYYoyoYear];
    [mutableDict setValue:self.player forKey:kTPYYoyoPlayer];
    [mutableDict setValue:self.response forKey:kTPYYoyoResponse];
    [mutableDict setValue:self.country forKey:kTPYYoyoCountry];
    [mutableDict setValue:self.name forKey:kTPYYoyoName];
    [mutableDict setValue:[self.material dictionaryRepresentation] forKey:kTPYYoyoMaterial];

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

    self.yoyoDescription = [aDecoder decodeObjectForKey:kTPYYoyoDescription];
    self.bearing = [aDecoder decodeObjectForKey:kTPYYoyoBearing];
    self.competitions = [aDecoder decodeObjectForKey:kTPYYoyoCompetitions];
    self.diameter = [aDecoder decodeDoubleForKey:kTPYYoyoDiameter];
    self.weight = [aDecoder decodeDoubleForKey:kTPYYoyoWeight];
    self.colors = [aDecoder decodeObjectForKey:kTPYYoyoColors];
    self.image = [aDecoder decodeObjectForKey:kTPYYoyoImage];
    self.manufacturer = [aDecoder decodeObjectForKey:kTPYYoyoManufacturer];
    self.year = [aDecoder decodeDoubleForKey:kTPYYoyoYear];
    self.player = [aDecoder decodeObjectForKey:kTPYYoyoPlayer];
    self.response = [aDecoder decodeObjectForKey:kTPYYoyoResponse];
    self.country = [aDecoder decodeObjectForKey:kTPYYoyoCountry];
    self.name = [aDecoder decodeObjectForKey:kTPYYoyoName];
    self.material = [aDecoder decodeObjectForKey:kTPYYoyoMaterial];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_yoyoDescription forKey:kTPYYoyoDescription];
    [aCoder encodeObject:_bearing forKey:kTPYYoyoBearing];
    [aCoder encodeObject:_competitions forKey:kTPYYoyoCompetitions];
    [aCoder encodeDouble:_diameter forKey:kTPYYoyoDiameter];
    [aCoder encodeDouble:_weight forKey:kTPYYoyoWeight];
    [aCoder encodeObject:_colors forKey:kTPYYoyoColors];
    [aCoder encodeObject:_image forKey:kTPYYoyoImage];
    [aCoder encodeObject:_manufacturer forKey:kTPYYoyoManufacturer];
    [aCoder encodeDouble:_year forKey:kTPYYoyoYear];
    [aCoder encodeObject:_player forKey:kTPYYoyoPlayer];
    [aCoder encodeObject:_response forKey:kTPYYoyoResponse];
    [aCoder encodeObject:_country forKey:kTPYYoyoCountry];
    [aCoder encodeObject:_name forKey:kTPYYoyoName];
    [aCoder encodeObject:_material forKey:kTPYYoyoMaterial];
}


@end
