//
//  socialTableViewController.m
//  BAC
//
//  Created by Subash Luitel on 4/25/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import "socialTableViewController.h"

@interface socialTableViewController ()

@end

@implementation socialTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    placesViewController  *placesVC = segue.destinationViewController;
    if ([[segue identifier] isEqualToString:@"taxiSegue"]) {
        placesVC.navigationItem.title = @"Nearby Taxi";
    }
    else if ([[segue identifier] isEqualToString:@"eatSegue"]) {
        placesVC.navigationItem.title = @"Places To Eat";
    }
    else if ([[segue identifier] isEqualToString:@"barsSegue"]) {
        placesVC.navigationItem.title = @"Nearby Bars";
    }
    else if ([[segue identifier] isEqualToString:@"nightLifeSegue"]) {
        placesVC.navigationItem.title = @"NightLife";
    }
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     , *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)shareButton:(id)sender {
    NSString* someText = @"I am using DrinkLab for iOS. Try is out. Its amazing!\nhttp://www.bajey.com";
    NSArray* dataToShare = @[someText];  // ...or whatever pieces of data you want to share.
    
    UIActivityViewController* activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:dataToShare
                                      applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:^{}];
}

- (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
