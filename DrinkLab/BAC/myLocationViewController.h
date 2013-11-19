//
//  myLocationViewController.h
//  BAC
//
//  Created by Subash Luitel on 4/18/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DDAnnotation.h"

@interface myLocationViewController : UIViewController <CLLocationManagerDelegate> {
    IBOutlet MKMapView *mapView;
    CLLocationCoordinate2D theCoordinate;
	CLLocationManager *currentLocation;
}

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *locationField;
@property (strong, nonatomic) CLLocationManager *locationManager;

- (void)showAnnotation;
@end
