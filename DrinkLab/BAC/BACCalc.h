//
//  BACCalc.h
//  graph
//
//  Created by Jonathan Hernandez on 3/27/13.
//  Copyright (c) 2013 Jonathan Hernandez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "bacAppDelegate.h"
#import <CoreData/CoreData.h>
#import "BACInfo.h"

@interface BACCalc : NSObject
-(void)addDrink: (NSNumber*)ounces withAlcPercentage: (NSNumber*) percAlc;
-(NSDate*)getHalfHourNow: (NSDate*)curr;
-(int)getHourIntFromDate: (NSDate*)curr;
-(int)getMinuteIntFromDate:(NSDate *)curr;
-(void)refreshTimeIndexAround: (NSDate*)arr;
-(double)getBACFromTime: (NSDate*) orig toTime:(NSDate*) curr withAlcPerc: (double)per andOunces: (double)oz;


    @property(strong, nonatomic) NSMutableArray *drinks;//array of drinks acquired
    @property(strong, nonatomic) NSMutableArray *bacValues;//BAC level per each relative time index time.
    @property(strong, nonatomic) NSMutableArray *timeIndex;//times from hour past to 5 hours forward
    @property(strong, nonatomic) NSMutableArray *bacIndex;//0-23 for graph
    @property(strong, nonatomic) NSDate *start;

@property (retain, nonatomic) bacAppDelegate *appDelegate;
@property (strong, nonatomic) NSMutableArray *bacInfoArray;


    

//maybe we should make weight and gender instance variable of this class also

@end
