//
//  logInViewController.h
//  BAC
//
//  Created by Subash Luitel on 4/3/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "registerViewController.h"
#import <CoreData/CoreData.h>
#import "LogInInfo.h"
#import "bacAppDelegate.h"
#import <Parse/Parse.h>

@interface logInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)signInButton:(id)sender;
- (IBAction)userFinishedEditing:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *resizableImage;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) logInViewController *loginVC;

@property (nonatomic, retain) NSMutableArray *array;
-(void) getData;
@property (retain, nonatomic) bacAppDelegate *appDelegate;
- (IBAction)appInfoButton:(id)sender;

@end
