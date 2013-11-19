//
//  reportViewController.h
//  BAC
//
//  Created by Subash Luitel on 4/3/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "BACCalc.h"
#import <CoreData/CoreData.h>
#import "BACCalculator.h"
#import "bacAppDelegate.h"
#import "BACInfo.h"


@interface reportViewController : UIViewController <CPTPlotDataSource>

@property (weak, nonatomic) IBOutlet CPTGraphHostingView *hostView;
@property (strong, nonatomic) BACCalc *theCalc;
-(void)refreshAxisLabels: (CPTXYAxis*)x;

@property (nonatomic, retain) NSMutableArray *bacInfoArray;
-(void) getData;
@property (retain, nonatomic) bacAppDelegate *appDelegate;

@end
