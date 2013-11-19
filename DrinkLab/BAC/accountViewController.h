//
//  accountViewController.h
//  BAC
//
//  Created by Subash Luitel on 4/3/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "registerViewController.h"
#import "bacAppDelegate.h"
#import <iAd/iAd.h>


@interface accountViewController : UIViewController <UINavigationControllerDelegate> 
@property (weak, nonatomic) IBOutlet UILabel *nameField;
@property (weak, nonatomic) IBOutlet UILabel *currentBACField;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePicture;

@property (strong, nonatomic) IBOutlet ADBannerView *bannerView;

@property (nonatomic, retain) NSMutableArray *array;
-(void) getData;
@property (retain, nonatomic) bacAppDelegate *appDelegate;
- (IBAction)logoutButtonPressed:(id)sender;
@end
