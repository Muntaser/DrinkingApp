//
//  detailDrinkViewController.h
//  BAC
//
//  Created by Subash Luitel on 4/8/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <CoreData/CoreData.h>
#import "BACCalculator.h"
#import "bacAppDelegate.h"
#import "BACInfo.h"

@interface detailDrinkViewController : UIViewController <ADBannerViewDelegate> {
    ADBannerView *bannerview;
    
    
}

@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UIButton *drinkButton;
@property (strong, nonatomic) IBOutlet UIButton *recommendButton;

-(IBAction)valueChanged:(id)sender;
- (IBAction)drinkButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet ADBannerView *bannerView;

@property (strong, nonatomic) NSDate *timeDrank;
@property float ABV;
@property float ounces;
@property (retain, nonatomic) bacAppDelegate *appDelegate;


@end
