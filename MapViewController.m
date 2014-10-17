//
//  MapViewController.m
//  CodeChallenge3
//
//  Created by Vik Denic on 10/16/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DivvyStationAnnotation.h"

@interface MapViewController () < MKMapViewDelegate, CLLocationManagerDelegate>
@property CLLocationManager *locationManager;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    [self.mapView addAnnotation:self.selectedDivvyStation];
    
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if (annotation == mapView.userLocation) {
        return nil;
    }
    
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:self.selectedDivvyStation reuseIdentifier:@"My Annotation"];
    
    annotationView.canShowCallout = YES;
    annotationView.enabled = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"bikeImage"]];
    DivvyStationAnnotation *divvyStation = (DivvyStationAnnotation *) annotation;
    
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:divvyStation reuseIdentifier:@"MyAnnotation"];
    }
    
    annotationView.image = [UIImage imageNamed:@"bikeImage"];
    return annotationView;
}








- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    [request setSource:[MKMapItem mapItemForCurrentLocation]];
    MKPlacemark *myPlaceMark = [[MKPlacemark alloc] initWithCoordinate:self.selectedDivvyStation.coordinate addressDictionary:nil];
    MKMapItem *myMapItem = [[MKMapItem alloc] initWithPlacemark:myPlaceMark];
    [request setDestination:myMapItem];
    [request setTransportType:MKDirectionsTransportTypeWalking];
    [request setRequestsAlternateRoutes:YES];
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (!error) {
            for (MKRoute *route in response.routes) {
                [self.mapView addOverlay:[route polyline] level:MKOverlayLevelAboveRoads];
                NSInteger routeTime = route.expectedTravelTime;
                self.title = @(routeTime).description;
                
                
            }
        }
    }];
}


@end
