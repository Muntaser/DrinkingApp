//
//  BACCalculator.h
//  BAC
//
//  Created by Subash Luitel on 4/9/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BACCalculator : NSObject

@property float BAC;
@property NSMutableArray *BACArray;
@property NSDate *now;
@property double hours;

- (float) calculateBAC: (float)percent
            withOunces:(float)ounces
            withWeight:(float)weight
    withNumberOfDrinks:(int)numberOfDrinks
         withDateDrank:(NSDate *)dateDrank;

@end
