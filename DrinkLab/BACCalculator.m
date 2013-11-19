//
//  BACCalculator.m
//  BAC
//
//  Created by Subash Luitel on 4/9/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import "BACCalculator.h"
#include "math.h"

@implementation BACCalculator

@synthesize BAC;
@synthesize BACArray;
@synthesize now;
@synthesize hours;

- (float) calculateBAC: (float)percent withOunces:(float)ounces withWeight:(float)weight withNumberOfDrinks: (int)numberOfDrinks withDateDrank:(NSDate *)dateDrank {
    hours = [[NSDate date] timeIntervalSinceDate:dateDrank];
    BAC = numberOfDrinks * ((ounces * percent * 0.075 / weight) - (hours * 1.5));
    return BAC;
}

@end
