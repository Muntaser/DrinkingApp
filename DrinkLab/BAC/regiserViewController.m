//
//  regiserViewController.m
//  BAC
//
//  Created by Subash Luitel on 4/3/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import "regiserViewController.h"

@interface regiserViewController ()

@end

@implementation regiserViewController
@synthesize userName = _userName;
@synthesize password =_password;
@synthesize confirmPassword = _confirmPassword;
@synthesize email = _email;
@synthesize sex = _sex;
@synthesize age = _age;
@synthesize weight = _weight;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    _userName.returnKeyType = UIReturnKeyDone;
    _userName.delegate = self;
    if (self) {
         }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)textFieldDidEndEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)registerButton:(id)sender {
}
@end
