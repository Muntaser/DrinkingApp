//
//  registerViewController.h
//  BAC
//
//  Created by Subash Luitel on 4/4/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "accountViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "bacAppDelegate.h"


@interface registerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *fullNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *sexField;
@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UITextField *weightField;
- (IBAction)registerButton:(id)sender;
- (IBAction)userFinishedEditing:(id)sender;
- (IBAction)GoBack:(id)sender;

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *goBackButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
@property (retain, nonatomic) bacAppDelegate *appDelegate;



@end
