//
//  StationsListViewController.m
//  CodeChallenge3
//
//  Created by Vik Denic on 10/16/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "StationsListViewController.h"
#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "DivvyStationAnnotation.h"

@interface StationsListViewController () <UITabBarDelegate, UITableViewDataSource, CLLocationManagerDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property CLLocationManager *locationManager;
@property NSMutableArray *divvyLocationArray;
@property (weak, nonatomic) IBOutlet UITableView *divvyStationTableView;

@end

@implementation StationsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    self.divvyLocationArray = [NSMutableArray array];
    self.locationManager.delegate = self;
    self.searchBar.delegate = self;
    [self urlRequest];

}


-(void)urlRequest{
    NSURL *url = [NSURL URLWithString:@"http://www.divvybikes.com/stations/json/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *jsonError = nil;
        NSDictionary *parsedResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        NSArray *results = [parsedResults valueForKey:@"stationBeanList"];
        for (NSDictionary *result in results){
            DivvyStationAnnotation *divvyStationInfo = [[DivvyStationAnnotation alloc] initWithJSONAndParse:result];
            [self.divvyLocationArray addObject:divvyStationInfo];
            NSLog(@"%@",divvyStationInfo.title);
        }
        [self.divvyStationTableView reloadData];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)cell{
    if ([segue.identifier isEqualToString:@"ToMapSegue"])
    {
        MapViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.selectedDivvyStation = [self.divvyLocationArray objectAtIndex:[self.divvyStationTableView indexPathForCell:cell].row];
        NSLog(@"This li");
//        [destinationViewController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    }
}

#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // TODO:
    return self.divvyLocationArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   DivvyStationAnnotation *divvyStation = [self.divvyLocationArray objectAtIndex:indexPath.row];
    
    NSLog(@"%@",divvyStation.iDNumber);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = divvyStation.title;
    cell.detailTextLabel.text = divvyStation.subtitle;
    return cell;
}

@end
