//
//  drinksViewController.m
//  BAC
//
//  Created by Subash Luitel on 4/3/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import "drinksViewController.h"


@interface drinksViewController () {
    NSMutableArray  *drinkTypes;
    NSMutableDictionary *drinksPerType;
}

@end

@implementation drinksViewController

-(void)awakeFromNib
{
    [super awakeFromNib];
    NSArray *allDrinks = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"drinks" ofType:@"plist"]];
    drinkTypes = [[NSMutableArray alloc] init];
    drinksPerType = [[NSMutableDictionary alloc] init];
    for (NSDictionary *drink in allDrinks) {
        NSString *typeName = drink[@"type"];
        NSMutableArray *drinksInType  = drinksPerType[typeName];
        if (!drinksInType) {
            [drinkTypes addObject:typeName];
            drinksInType = [[NSMutableArray alloc] init];
            drinksPerType[typeName] = drinksInType;
        }
        [drinksInType addObject:drink];
    }
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return drinkTypes.count;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Drink *aDrink = [collectionView dequeueReusableCellWithReuseIdentifier:@"drinkCell" forIndexPath:indexPath];
    aDrink.drinkLabel.text = drinkTypes[indexPath.row];
    aDrink.drinkImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", drinkTypes[indexPath.row]]];
    return aDrink;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"showDrinks"]) {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        subDrinksViewController *destViewController = segue.destinationViewController;
        NSIndexPath *index = [indexPaths objectAtIndex:0];
        destViewController.navigationItem.title = drinkTypes[index.row];
        NSString *typeName = drinkTypes[index.row];
        NSArray *drinksInType = drinksPerType[typeName];
        destViewController.drinks = drinksInType;
        if ([drinkTypes[index.row] isEqualToString:@"Beer"]) {
            destViewController.ounces = 12;
        }
        else if ([drinkTypes[index.row] isEqualToString:@"Wine"]) {
            destViewController.ounces = 6;
        }
        else if ([drinkTypes[index.row] isEqualToString:@"Whiskey"]) {
            destViewController.ounces = 5;
        }
        if ([drinkTypes[index.row] isEqualToString:@"Rum"]) {
            destViewController.ounces = 4;
        }
    }
}

- (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}



@end
