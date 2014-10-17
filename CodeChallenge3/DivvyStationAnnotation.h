//
//  DivvyStationAnnotation.h
//  CodeChallenge3
//
//  Created by Adam Cooper on 10/17/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DivvyStationAnnotation : NSObject <MKAnnotation>
@property (readonly) NSNumber *iDNumber;
@property (readonly) NSNumber *availableDocks;
@property (readonly) NSNumber *totalDocks;
@property (readonly) NSString *statusValue;
@property (readonly) NSNumber *statusKey;
@property (readonly) NSNumber *availableBikes;
@property (readonly) NSString *streetAddress;
@property (readonly) NSString *locationString;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (copy,nonatomic) NSString *title;


-(instancetype)initWithJSONAndParse:(NSDictionary *)jSONDictionary;

@end
