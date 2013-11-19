//
//  socialViewController.h
//  BAC
//
//  Created by Subash Luitel on 4/3/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>


@interface socialViewController : UIViewController <FBFriendPickerDelegate>
- (IBAction)inviteFriendsButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *friendsTextField;
@property (retain, nonatomic) FBFriendPickerViewController *friendPickerController;
- (void)fillTextBoxAndDismiss:(NSString *)text;

@end
