//
//  regiserViewController.h
//  BAC
//
//  Created by Subash Luitel on 4/3/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface regiserViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *sex;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *weight;
- (IBAction)textFieldDidEndEditing:(id)sender;
- (IBAction)registerButton:(id)sender;

@end
