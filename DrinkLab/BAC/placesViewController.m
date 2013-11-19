//
//  placesViewController.m
//  BAC
//
//  Created by Subash Luitel on 4/25/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import "placesViewController.h"

@interface placesViewController () <MKMapViewDelegate, ABUnknownPersonViewControllerDelegate>

@property (nonatomic, strong) NSOperationQueue *searchQueue;

@end

@implementation placesViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.searchQueue = [[NSOperationQueue alloc] init];
    self.searchQueue.maxConcurrentOperationCount = 1;
    
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow];
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    MKMapRect mapRect = mapView.visibleMapRect;
    MKMapPoint eastMapPoint = MKMapPointMake(MKMapRectGetMinX(mapRect), MKMapRectGetMidY(mapRect));
    MKMapPoint westMapPoint = MKMapPointMake(MKMapRectGetMaxX(mapRect), MKMapRectGetMidY(mapRect));
    
    CGFloat meters = MKMetersBetweenMapPoints(eastMapPoint, westMapPoint);
    
    if (meters > 5000)
        return;
    
    // if we have some backlogged requests, let's just get rid of them
    
    [self.searchQueue cancelAllOperations];
    
    // issue new MKLoadSearch
    
    [self.searchQueue addOperationWithBlock:^{
        
        __block BOOL done = NO;
        
        MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
        if ([self.navigationItem.title isEqualToString:@"Places To Eat"]) {
            request.naturalLanguageQuery = @"resturant";
        }
        else if ([self.navigationItem.title isEqualToString:@"Nearby Taxi"]) {
            request.naturalLanguageQuery = @"taxi";
        }
        else if ([self.navigationItem.title isEqualToString:@"Nearby Bars"]) {
            request.naturalLanguageQuery = @"bar";
        }
        else if ([self.navigationItem.title isEqualToString:@"NightLife"]) {
            request.naturalLanguageQuery = @"night club";
        }
            
        request.region = mapView.region;
        
        MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:request];
        [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
            
            NSMutableArray *annotations = [NSMutableArray array];
            
            [response.mapItems enumerateObjectsUsingBlock:^(MKMapItem *item, NSUInteger idx, BOOL *stop) {
                
                for (CustomAnnotation *annotation in mapView.annotations)
                {
                    // if we don't need this one, don't add it, just return, and we'll check the next one
                    
                    if ([annotation isKindOfClass:[CustomAnnotation class]])
                        if (item.placemark.coordinate.latitude == annotation.coordinate.latitude &&
                            item.placemark.coordinate.longitude == annotation.coordinate.longitude)
                        {
                            return;
                        }
                }
                
                // otherwise add it
                
                CustomAnnotation *annotation = [[CustomAnnotation alloc] initWithPlacemark:item.placemark];
                annotation.title = item.name;
                annotation.phone = item.phoneNumber;
                annotation.subtitle = item.placemark.addressDictionary[(NSString *)kABPersonAddressStreetKey];
                [annotations addObject:annotation];
            }];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.mapView addAnnotations:annotations];
            }];
            
            done = YES;
        }];
        
        while (!done)
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                     beforeDate:[NSDate distantFuture]];
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (![annotation isKindOfClass:[CustomAnnotation class]])
        return nil;
    
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                                       reuseIdentifier:@"CustomAnnotationView"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if (![view.annotation isKindOfClass:[CustomAnnotation class]])
        return;
    CustomAnnotation *annotation = (CustomAnnotation *)view.annotation;
    
    ABRecordRef person = ABPersonCreate();
    ABRecordSetValue(person, kABPersonOrganizationProperty, (__bridge CFStringRef) annotation.title, NULL);
    
    if (annotation.phone)
    {
        ABMutableMultiValueRef phoneNumberMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(phoneNumberMultiValue, (__bridge CFStringRef) annotation.phone, kABPersonPhoneMainLabel, NULL);
        ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumberMultiValue, nil);
        CFRelease(phoneNumberMultiValue);
    }
    
    ABMutableMultiValueRef address = ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
    ABMultiValueAddValueAndLabel(address, (__bridge CFDictionaryRef) annotation.addressDictionary, kABWorkLabel, NULL);
    ABRecordSetValue(person, kABPersonAddressProperty, address, NULL);
    ABUnknownPersonViewController *personView = [[ABUnknownPersonViewController alloc] init];
    
    personView.unknownPersonViewDelegate = self;
    personView.displayedPerson = person;
    personView.allowsAddingToAddressBook = YES;
    
    [self.navigationController pushViewController:personView animated:YES];
    
    CFRelease(address);
    CFRelease(person);
}

// Animation from http://stackoverflow.com/a/7045872/1271826

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MKAnnotationView *annotationView;
    
    for (annotationView in views) {
        
        // Don't pin drop if annotation is user location
        if ([annotationView.annotation isKindOfClass:[MKUserLocation class]]) {
            continue;
        }
        
        // Check if current annotation is inside visible map rect, else go to next one
        MKMapPoint point =  MKMapPointForCoordinate(annotationView.annotation.coordinate);
        if (!MKMapRectContainsPoint(self.mapView.visibleMapRect, point)) {
            continue;
        }
        
        CGRect endFrame = annotationView.frame;
        
        // Move annotation out of view
        annotationView.frame = CGRectMake(annotationView.frame.origin.x, annotationView.frame.origin.y - self.view.frame.size.height, annotationView.frame.size.width, annotationView.frame.size.height);
        
        // Animate drop
        [UIView animateWithDuration:0.4
                              delay:0.04*[views indexOfObject:annotationView]
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             
                             annotationView.frame = endFrame;
                             
                             // Animate squash
                         }
                         completion:^(BOOL finished){
                             if (finished) {
                                 [UIView animateWithDuration:0.05
                                                  animations:^{
                                                      annotationView.transform = CGAffineTransformMakeScale(1.0, 0.8);
                                                      
                                                  }
                                                  completion:^(BOOL finished){
                                                      if (finished) {
                                                          [UIView animateWithDuration:0.1 animations:^{
                                                              annotationView.transform = CGAffineTransformIdentity;
                                                          }];
                                                      }
                                                  }];
                             }
                         }];
    }
}


- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownPersonView didResolveToPerson:(ABRecordRef)person
{
    
}

//- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
//{
//    if ([view.annotation isKindOfClass:[CustomAnnotation class]])
//    {
//        CustomAnnotation *annotation = view.annotation;
//        NSLog(@"index = %d; property1 = %@", annotation.index, annotation.property1);
//    }
//}


@end
