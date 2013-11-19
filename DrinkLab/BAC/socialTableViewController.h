//
//  socialTableViewController.h
//  BAC
//
//  Created by Subash Luitel on 4/25/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "placesViewController.h"

@interface socialTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableViewCell *myCircleCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *findATaxiCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *placesToEatCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *nearbyBarsCell;
- (IBAction)shareButton:(id)sender;
@end
