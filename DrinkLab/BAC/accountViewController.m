//
//  accountViewController.m
//  BAC
//
//  Created by Subash Luitel on 4/3/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import "accountViewController.h"
#import "Person.h"
#import "BACCalculator.h"
#import "registerViewController.h"
#import "LogInInfo.h"
#import <CoreData/CoreData.h>
#import "bacAppDelegate.h"

@interface accountViewController () {
    BOOL didLogout;
}

@end

@implementation accountViewController
@synthesize nameField = _nameField;
@synthesize currentBACField = _currentBACField;
@synthesize profilePicture;

@synthesize array, appDelegate, bannerView;

//-(void) getData {
//    NSManagedObjectContext *context = [appDelegate managedObjectContext];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"LogInInfo" inManagedObjectContext:context];
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setFetchBatchSize:20];
//    [request setEntity:entity];
//    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"userName" ascending:YES];
//    NSArray *newArray = [NSArray arrayWithObject:sort];
//    [request setSortDescriptors:newArray];
//    NSError *error;
//    NSMutableArray *results = [[context executeFetchRequest:request error:&error] mutableCopy];
//    [self setArray:results];
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Facebook Stuff
    if (FBSession.activeSession.isOpen) {
        [FBRequestConnection
         startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                           id<FBGraphUser> user,
                                           NSError *error) {
             if (!error) {
                 NSString *userName = @"";
                 self.profilePicture.profileID = user.id;
                 
                userName = [userName
                             stringByAppendingString:
                             [NSString stringWithFormat:@"%@",
                              user.name]];
                 
                 self.nameField.text = userName;
                 
             }
         }];
    }
//    else {
//        for (int i=0; i<array.count; i++) {
//            LogInInfo *info = [array objectAtIndex:i];
//                
//            }
//    }
//
    //BACCalculator *calculator = [[BACCalculator alloc] init];

//    _currentBACField.text =
//    [NSString stringWithFormat:@"%f",
//     [calculator calculateBAC:4 withOunces:12 withWeight:120]];
    
    _currentBACField.text = [NSString stringWithFormat:@"0.08%%"];
    appDelegate = (bacAppDelegate *)[[UIApplication sharedApplication] delegate];
//    [self getData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(void)bannerViewDidLoadAd:(ADBannerView *)abanner {
    [UIView beginAnimations:@"animatedAdBannerOn" context:NULL];
    [UIView commitAnimations];
}
-(void)bannerView:(ADBannerView *)aBanner didFailToReceiveAdWithError:(NSError *)error {
    [UIView beginAnimations:@"animatedAdBannerOff" context:NULL];
    [UIView commitAnimations];
}

- (IBAction)logoutButtonPressed:(id)sender {
    appDelegate = (bacAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    LogInInfo *detail = [NSEntityDescription insertNewObjectForEntityForName:@"LogInInfo"
                                                      inManagedObjectContext:context];
    detail.userID = @"Unknown";
    detail.isLoggedIn = @"NO";
    didLogout = YES;
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Error, Fool!");
    }
    [self performSegueWithIdentifier:@"logoutSegue" sender:self];
}
@end
