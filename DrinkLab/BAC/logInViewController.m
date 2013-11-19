//
//  logInViewController.m
//  BAC
//
//  Created by Subash Luitel on 4/3/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import "logInViewController.h"
#import "bacAppDelegate.h"
#import "drinksViewController.h"

@interface logInViewController () <FBLoginViewDelegate> {
     BOOL passLogIn;
    BOOL passRegister;
    BOOL passFacebook;
}

@end

@implementation logInViewController

@synthesize resizableImage, registerButton;
@synthesize loginVC;
@synthesize array, appDelegate, userNameField, passwordField;

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self saveData];
    UIImage *buttonImage = [[UIImage imageNamed:@"green.png"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 16)];
    [self.resizableImage setBackgroundImage: buttonImage
                                   forState:UIControlStateNormal];
    [self.registerButton setBackgroundImage: buttonImage
                                   forState:UIControlStateNormal];

    FBLoginView *logInView = [[FBLoginView alloc] init];
    logInView.delegate = self;
    if (passFacebook) {
        [self performSegueWithIdentifier:@"SignIn" sender:self];
    }
    appDelegate = (bacAppDelegate *)[[UIApplication sharedApplication] delegate];
    passLogIn = NO;
    
}

- (void)viewDidAppear:(BOOL)animated {
//    FBLoginView *logInView = [[FBLoginView alloc] init];
//    logInView.delegate = self;
//    if (passFacebook) {
//        [self performSegueWithIdentifier:@"SignIn" sender:self];
//    }
//    appDelegate = (bacAppDelegate *)[[UIApplication sharedApplication] delegate];
//    passLogIn = NO;
//    
    //Check Core Data
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"LogInInfo"
                                              inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setFetchBatchSize:20];
    [request setEntity:entity];
    
    //sort the array
//    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"isLoggedIn"
//                                                         ascending:NO];
//    NSArray *newArray = [NSArray arrayWithObject:sort];
//    [request setSortDescriptors:newArray];
    
    NSError *error;
    NSMutableArray *results = [[context executeFetchRequest:request
                                                      error:&error] mutableCopy];
    [self setArray:results];
        LogInInfo *info = [array lastObject];
        if ([info.isLoggedIn isEqualToString:@"YES"]) {
            passLogIn = YES;
            [self performSegueWithIdentifier:@"SignIn" sender:self];
        }
    //see the array
    for (int i=0; i<array.count; i++) {
        LogInInfo *info = [array objectAtIndex:i];
        NSLog([NSString stringWithFormat:@"%@",info.isLoggedIn]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)registerLogIn:(id)sender {
    [self performSegueWithIdentifier:@"register1" sender:self];
    passRegister = YES;
}

- (IBAction)signInButton:(id)sender {
//    [self getData];
    //queries PARSE for the username and checks if the passwords match
    PFQuery *attempt=[[PFQuery alloc] initWithClassName:@"user"];
    [attempt whereKey:@"username" matchesRegex:userNameField.text];
    
    PFObject *user;
    user = [attempt getFirstObject];
    if(user && [passwordField.text isEqualToString:[user objectForKey:@"password"]])
    {
        NSLog(@"age %@, male %@, objectId: %@", [user objectForKey:@"age"], [user objectForKey:@"male"], [user objectId]);
        passLogIn = YES;
        //Store in Core Data
        //appDelegate = (bacAppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        LogInInfo *detail = [NSEntityDescription insertNewObjectForEntityForName:@"LogInInfo"
                                                          inManagedObjectContext:context];
        detail.userID = [user objectId];
        detail.isLoggedIn = @"YES";
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Error, Fool!");
        }
    }

    if (!passLogIn) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Login!"
                                                        message:@"The user name and password you provided donot match."
                                                       delegate:nil cancelButtonTitle:@"Try Again"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
        [self performSegueWithIdentifier:@"SignIn" sender:self];
    }
    }


-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    if([identifier isEqual:@"register1"]){
        return passRegister;
    }
   
    else if([identifier isEqual:@"SignIn"]){
    return passLogIn;
    }
    return NO;
}

- (IBAction)userFinishedEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)appInfoButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DrinkLab"
                                                    message:@"Developers\nSubash Luitel\nJonathan Hernandez\nMuntaser Khan."
                                                   delegate:nil cancelButtonTitle:@"Got It"
                                          otherButtonTitles:nil];
    [alert show];
}

- (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


@end
