//
//  DivvyStationAnnotation.m
//  CodeChallenge3
//
//  Created by Adam Cooper on 10/17/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "DivvyStationAnnotation.h"

@implementation DivvyStationAnnotation{
    NSDictionary *json;
}

-(instancetype)initWithJSONAndParse:(NSDictionary *)jSONDictionary{
    self = [super init];
    if (self) {
        json = jSONDictionary;
    }
    return self;
}

-(NSNumber *) iDNumber{
    return json[@"id"];
}
-(NSNumber *)availableDocks{
    return json[@"availableDocks"];
    
}
-(NSNumber *)totalDocks{
    return json[@"totalDocks"];
    
}
-(NSString *)statusValue{
    return json[@"statusValue"];
    
}
-(NSNumber *)statusKey{
    return json[@"statusKey"];
    
}

-(NSNumber *)availableBikes{
    return json[@"availableBikes"];
    
}

-(NSString *)streetAddress{
    return json[@"stAddress1"];
    
}
-(NSString *)locationString{
    return json[@"location"];
    
}


-(CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D newCoordinate;
    newCoordinate.latitude = [json[@"latitude"]doubleValue];
    if ([json[@"longitude"]doubleValue] < 0) {
        newCoordinate.longitude = [json[@"longitude"]doubleValue];
    } else {
        newCoordinate.longitude = -[json[@"longitude"]doubleValue];
    }
    return newCoordinate;
}


-(NSString *)title{
    return json[@"stationName"];
}

-(NSString *)subtitle{
    return json[@"stAddress1"];
}





@end




