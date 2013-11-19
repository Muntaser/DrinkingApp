//
//  socialViewController.m
//  BAC
//
//  Created by Subash Luitel on 4/3/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import "socialViewController.h"

@interface socialViewController ()


@end

@implementation socialViewController
@synthesize friendsTextField;
@synthesize friendPickerController;


- (void)viewDidLoad
{
    socialViewController *svc;
    svc.navigationController.title = @"Social";
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (!FBSession.activeSession.isOpen) {
        // if the session is closed, then we open it here, and establish a handler for state changes
        [FBSession.activeSession openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState state,
                                                             NSError *error) {
            switch (state) {
                case FBSessionStateClosedLoginFailed:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:error.localizedDescription
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }
                    break;
                default:
                    break;
            }
        }];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)inviteFriendsButton:(id)sender {
    if (self.friendPickerController == nil) {
        // Create friend picker, and get data loaded into it.
        self.friendPickerController = [[FBFriendPickerViewController alloc] init];
        self.friendPickerController.title = @"Pick Friends";
        self.friendPickerController.delegate = self;
    }
    
    [self.friendPickerController loadData];
    [self.friendPickerController clearSelection];
    [self presentViewController:self.friendPickerController animated:YES completion:nil];
}

- (void)facebookViewControllerDoneWasPressed:(id)sender {
    NSMutableString *text = [[NSMutableString alloc] init];
    
    // we pick up the users from the selection, and create a string that we use to update the text view
    // at the bottom of the display; note that self.selection is a property inherited from our base class
    for (id<FBGraphUser> user in self.friendPickerController.selection) {
        if ([text length]) {
            [text appendString:@", "];
        }
        [text appendString:user.name];
    }
    
    [self fillTextBoxAndDismiss:text.length > 0 ? text : @"<None>"];
}

- (void)facebookViewControllerCancelWasPressed:(id)sender {
    [self fillTextBoxAndDismiss:@"<Cancelled>"];
}

- (void)fillTextBoxAndDismiss:(NSString *)text {
    self.friendsTextField.text = text;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return YES;
}

- (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}



@end
