//
//  subDrinksViewController.m
//  BAC
//
//  Created by Subash Luitel on 4/7/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import "subDrinksViewController.h"

@interface subDrinksViewController ()

@end

@implementation subDrinksViewController
@synthesize drinks, ounces;

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.drinks.count;
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubDrink *aSubDrink = [collectionView dequeueReusableCellWithReuseIdentifier:@"subDrinkCell" forIndexPath:indexPath];
    NSDictionary *drink = self.drinks[indexPath.row];
    aSubDrink.subDrinkLabel.text = drink[@"name"];
    aSubDrink.subDrinkImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", drink[@"picture"]]];
    return aSubDrink;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        detailDrinkViewController *destViewController = segue.destinationViewController;
        NSIndexPath *index = [indexPaths objectAtIndex:0];
        NSDictionary *specificDrink = drinks[index.row];
        destViewController.navigationItem.title = specificDrink[@"name"];
        destViewController.ABV = [specificDrink[@"ABV"] floatValue];
        destViewController.ounces = self.ounces;
    }
}

- (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}



@end
