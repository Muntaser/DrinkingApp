//
//  detailDrinkViewController.m
//  BAC
//
//  Created by Subash Luitel on 4/8/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import "detailDrinkViewController.h"

@interface detailDrinkViewController ()

@end

@implementation detailDrinkViewController

@synthesize label, slider, drinkButton, recommendButton, bannerView;
@synthesize timeDrank, ABV, ounces, appDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	label.text = @"1 bottle(s)";
    UIImage *buttonImage = [[UIImage imageNamed:@"green.png"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 16)];
    [self.drinkButton setBackgroundImage:
     buttonImage forState:UIControlStateNormal];
    [self.recommendButton setBackgroundImage: buttonImage
                                    forState:UIControlStateNormal];
    bannerView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)valueChanged:(id)sender {
    int currentValue;
    currentValue = [slider value];
    NSString *valueChange = [[NSString alloc] initWithFormat:@"%i bottle(s)",currentValue];
    label.text = valueChange;
}

- (IBAction)drinkButtonPressed:(id)sender {
    //Core Data Implementation
    appDelegate = (bacAppDelegate *)[[UIApplication sharedApplication] delegate];
    
   NSManagedObjectContext *context = [appDelegate managedObjectContext];
    BACInfo *detailBAC = [NSEntityDescription insertNewObjectForEntityForName:@"BACInfo"
                                                      inManagedObjectContext:context];
    detailBAC.abv = [NSNumber numberWithFloat:self.ABV];
    detailBAC.ounces = [NSNumber numberWithFloat:self.ounces];
    detailBAC.timeDrank = [NSDate date];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Error, Fool!");
    }

}

-(void)bannerViewDidLoadAd:(ADBannerView *)abanner {
        [UIView beginAnimations:@"animatedAdBannerOn" context:NULL];
        [UIView commitAnimations];
}
-(void)bannerView:(ADBannerView *)aBanner didFailToReceiveAdWithError:(NSError *)error {
        [UIView beginAnimations:@"animatedAdBannerOff" context:NULL];
        [UIView commitAnimations];
}




@end
