//
//  myLocationViewController.m
//  BAC
//
//  Created by Subash Luitel on 4/18/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import "myLocationViewController.h"
#import "DDAnnotation.h"

@interface myLocationViewController () 

@end

@implementation myLocationViewController
@synthesize mapView, locationManager, locationField;

- (void)showAnnotation
{
	//theCoordinate.latitude = 26.926;
    //theCoordinate.longitude = 75.8235;
	MKCoordinateRegion region;
	region.center = theCoordinate;
	MKCoordinateSpan span;
	span.latitudeDelta = 0.005;
	span.longitudeDelta = 0.005;
	region.span=span;
	[mapView setRegion:region animated:TRUE];
	
	DDAnnotation *annotation = [[DDAnnotation alloc] initWithCoordinate:theCoordinate addressDictionary:nil];
	annotation.title = @"Current Location";
	annotation.subtitle = @"";
	
	[self.mapView addAnnotation:annotation];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    currentLocation = [[CLLocationManager alloc]init];
	currentLocation.desiredAccuracy = kCLLocationAccuracyBest;
	currentLocation.delegate = self;
	[currentLocation startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [currentLocation stopUpdatingLocation];
	theCoordinate.latitude = newLocation.coordinate.latitude;
	theCoordinate.longitude = newLocation.coordinate.longitude;
	[self showAnnotation];
    
    
    CLLocation *currentLocation = [self.locationManager location];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //[self.locationField setText:[NSString stringWithFormat:@"%f",  currentLocation.coordinate.latitude]];
////    [self.longitudeLabel setText:[NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude]];
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0) {
            // Pick the best out of the possible placemarks
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSString *addressString = [placemark name];
            [self.locationField setText:addressString];
        }
        
    }];
    
//    CLLocation *pionerLocation = [[CLLocation alloc] initWithLatitude:39.524411 longitude:-119.811419];
//    CLLocationDistance distance = [currentLocation distanceFromLocation:pionerLocation];
//    //[self.distanceLabel setText:[NSString stringWithFormat:@"%f m", distance]];
    
    
}




@end
