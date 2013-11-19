//
//  registerViewController.m
//  BAC
//
//  Created by Subash Luitel on 4/4/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import "registerViewController.h"
#import "RegisteredUsers.h"
#import "LogInInfo.h"
#import "bacAppDelegate.h"

@interface registerViewController ()

@end

@implementation registerViewController

@synthesize userNameField;
@synthesize fullNameField;
@synthesize passwordField;
@synthesize confirmPasswordField;
@synthesize ageField;
@synthesize sexField;
@synthesize emailField;
@synthesize weightField;

@synthesize goBackButton, registerButton;

@synthesize  appDelegate;

- (void)viewDidLoad
{
    NSDate * today = [NSDate date];
    NSLog(@"today: %@", today);
    [super viewDidLoad];
    
    UIImage *buttonImage = [[UIImage imageNamed:@"green.png"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 16)];
    [self.goBackButton setBackgroundImage: buttonImage
                                 forState:UIControlStateNormal];
    [self.registerButton setBackgroundImage: buttonImage
                                   forState:UIControlStateNormal];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)registerButton:(id)sender {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if(![passwordField.text isEqual: confirmPasswordField.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid !"
                                                        message:@"The passwords don't match ."
                                                       delegate:nil cancelButtonTitle:@"Try Again"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    else if(!([sexField.text isEqual:@"Male"] || [sexField.text isEqual:@"Female"])){
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid sex"
                                                    message:@"Put male or female in ."
                                                   delegate:nil cancelButtonTitle:@"Try Again"
                                          otherButtonTitles:nil];
        [alert show];
    
    }
    
    else if([emailTest evaluateWithObject:emailField.text] ==false){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid email address"
                                                        message:@"Enter a valid email address."
                                                       delegate:nil
                                              cancelButtonTitle:@" Please Try Again"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    else {
        PFQuery *attempt=[[PFQuery alloc] initWithClassName:@"user"];
        [attempt whereKey:@"username" matchesRegex:userNameField.text];
        PFObject *user;
        user = [attempt getFirstObject];
        if(user){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Username already exists"
                                                        message:@"Please try a different username."
                                                       delegate:nil
                                              cancelButtonTitle:@" Please Try Again"
                                              otherButtonTitles:nil];
            [alert show];
        }
        else {
            NSNumber *temp;
            if([sexField.text isEqualToString:@"Male"])
                temp = [NSNumber numberWithInt:1];
            else temp= [NSNumber numberWithInt:0];
            NSNumber *agee = [NSNumber numberWithInt:[ageField.text intValue]];
            NSNumber *weight = [NSNumber numberWithInt:[weightField.text intValue]];
            
            
            PFObject *registered = [[PFObject alloc] initWithClassName:@"user"];
            [registered setObject:userNameField.text forKey:@"username"];
            [registered setObject:passwordField.text forKey:@"password"];
            [registered setObject:temp forKey:@"male"];
            [registered setObject:weight forKey:@"weight"];
            [registered setObject:agee forKey:@"age"];
            [registered save];
            
            //Core Data Implementation
            appDelegate = (bacAppDelegate *)[[UIApplication sharedApplication] delegate];
            NSManagedObjectContext *context = [appDelegate managedObjectContext];
            LogInInfo *detail = [NSEntityDescription insertNewObjectForEntityForName:@"LogInInfo"
                                                              inManagedObjectContext:context];
            detail.userID = [user objectId];
            detail.isLoggedIn = @"YES";
            
            NSError *error;
            if (![context save:&error]) {
                NSLog(@"Error, Fool!");
            }
            [self performSegueWithIdentifier:@"finishedRegister" sender:self];

        }
    }
}

- (IBAction)userFinishedEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)GoBack:(id)sender {
    }

- (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}






@end
