//
//  bacAppDelegate.h
//  BAC
//
//  Created by Subash Luitel on 2/22/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <CoreData/CoreData.h>
#import "regiserViewController.h"
#import <Parse/Parse.h>

@class logInViewController;
@class drinksViewController;


@interface bacAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate, UITabBarControllerDelegate> {
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;

//added for facebook
@property (strong, nonatomic) logInViewController *viewController;
@property  (strong, nonatomic) drinksViewController *drinksViewController;
@property (strong, nonatomic) FBSession *session;
@end
