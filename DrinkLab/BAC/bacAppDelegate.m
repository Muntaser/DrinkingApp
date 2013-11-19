//
//  bacAppDelegate.m
//  BAC
//
//  Created by Subash Luitel on 2/22/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import "bacAppDelegate.h"
#import "logInViewController.h"
#import "accountViewController.h"


@implementation bacAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize session = _session;
@synthesize drinksViewController = _drinksViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"YICWrh2fvYPymLk5vAZ1Vg3bUGdZo3Vbg316eiCm"
                  clientKey:@"1zg3A7F6EzPnweNL9lc9ND8iQDGh025uJmcQETQb"];
//    accountViewController *accountVC = [[accountViewController alloc] init];
//    accountVC.context = self.managedObjectContext;
    

    
    UIImage *navBackgroundImage = [UIImage imageNamed:@"navbar_bg"];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
//
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], UITextAttributeTextColor,
                                                           [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],UITextAttributeTextShadowColor,
                                                           [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
                                                           UITextAttributeTextShadowOffset,
                                                           [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], UITextAttributeFont, nil]];

    // Change the appearance of back button
    UIImage *backButtonImage = [[UIImage imageNamed:@"button_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 6)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    // Change the appearance of other navigation button
    UIImage *barButtonImage = [[UIImage imageNamed:@"button_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
//    [[UITabBar appearance] setTintColor:[UIColor /*colorWithPatternImage:[UIImage imageNamed:@"Green-Background.gif"]*/greenColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor whiteColor] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor whiteColor] }
                                             forState:UIControlStateHighlighted];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor greenColor]];
    
    return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    [self.session close];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBSession.activeSession handleOpenURL:url];
    //return [self.session handleOpenURL:url];
}

//Explicitly write Core Data accessors
- (NSManagedObjectContext *) managedObjectContext {
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"BAC.sqlite"]];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
    						 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
    						 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel:[self managedObjectModel]];
    if(![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                 configuration:nil URL:storeUrl options:options error:&error]) {
        /*Error for store creation should be handled in here*/
    }
    
    return persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}






@end
