//
//  subDrinksViewController.h
//  BAC
//
//  Created by Subash Luitel on 4/7/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubDrink.h"
#import "detailDrinkViewController.h"

@interface subDrinksViewController : UICollectionViewController
@property (strong, nonatomic) NSArray *drinks;
@property float ounces;

@end
