//
//  placesViewController.h
//  BAC
//
//  Created by Subash Luitel on 4/25/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CustomAnnotation.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
@interface placesViewController : UIViewController
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSString *header;

@end
