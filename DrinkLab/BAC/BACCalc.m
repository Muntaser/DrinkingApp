//
//  BACCalc.m
//  graph
//
//  Created by Jonathan Hernandez on 3/27/13.
//  Copyright (c) 2013 Jonathan Hernandez. All rights reserved.
//

#import "BACCalc.h"
#import "BACCalculator.h"

@implementation BACCalc{
    double weight; //in pounds
    double genderConst; //men=.73 women=.66
    
}
int halfHr = 1800; //1800 seconds in half hour
int fullHr = 3600; //3600 seconds in an hour

@synthesize appDelegate, bacInfoArray;

//PRESENT TIME IS IN INDEX 2
/*
 - (float) calculateBAC: (float)percent withOunces:(float)ounces  withWeight:(float)weight{
    //NSDate *start = [NSDate date];
    // do stuff...
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:118800];
    hours = [date timeIntervalSinceNow];
    BAC = (ounces * percent * 0.075 / weight) - (hours * 0.015);
    return BAC;
}
 */

//Get Data from the Core Data database
//This method added by subash
-(void) getData {
    appDelegate = (bacAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BACInfo" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setFetchBatchSize:20];
    [request setEntity:entity];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"timeDrank" ascending:NO];
    NSArray *newArray = [NSArray arrayWithObject:sort];
    [request setSortDescriptors:newArray];
    NSError *error;
    NSMutableArray *results = [[context executeFetchRequest:request error:&error] mutableCopy];
    [self setBacInfoArray:results];
}

-(id)init
{
    self = [super init];
    if(self){
        weight = 150;
        genderConst = .73;
        self.bacValues = [[NSMutableArray alloc] init];
        self.bacIndex = [[NSMutableArray alloc] init];
        self.timeIndex = [[NSMutableArray alloc] init];
        
        self.start = [ self getHalfHourNow:[NSDate date]];
        
        NSDate *next = [[NSDate alloc] initWithTimeInterval:-(2 * halfHr) sinceDate:_start];
        
        
        NSMutableString *temp;
        NSDate *nextDate = [[NSDate alloc] init];
        nextDate = [NSDate date];
        [self getData];
        for(int i = 0; i < 24; i++){
            BACCalculator *calculator = [[BACCalculator alloc] init];
            BACInfo *info = bacInfoArray.lastObject;
            float BAC = [calculator calculateBAC : [info.abv floatValue]
                                       withOunces:[info.ounces floatValue]
                                       withWeight:160
                               withNumberOfDrinks: 2
                                    withDateDrank:nextDate];

            [self.bacValues addObject: [NSNumber numberWithFloat:BAC]];
            [nextDate dateByAddingTimeInterval:1800];
            NSLog([NSString stringWithFormat:@"%f", BAC]);
           
            temp = [[NSMutableString alloc] init];
            temp = [NSString stringWithFormat:@"%d:%d",[self getHourIntFromDate:next], [self getMinuteIntFromDate:next]];
            [_timeIndex addObject:temp];
      
            next = [[NSDate alloc] initWithTimeInterval:halfHr sinceDate:next];           
            
            [self.bacIndex addObject: [NSNumber numberWithInt:i]];
        }
        
    }
    return self;
}



-(void)refreshTimeIndexAround: (NSDate*)new
{
        
    
    /* This segment reinitializes the time array needed for the time labels if there is a
     nonzero value for unitsElapsed. May be inefficeent since it reallocates a whole array
     even if one one time unit passed... may come back to improve*/
    NSDate *next = [[NSDate alloc] initWithTimeInterval:-(2 * halfHr) sinceDate:new];
    NSMutableString *temp = [[NSMutableString alloc] init];
    _timeIndex = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < 24; i++){
        temp = [[NSMutableString alloc] init];
        temp = [NSString stringWithFormat:@"%d:%d",[self getHourIntFromDate:next], [self getMinuteIntFromDate:next]];
        [_timeIndex addObject:temp];
        
        next = [[NSDate alloc] initWithTimeInterval:halfHr sinceDate:next];
    }    
}
//NOT comp;ete... inserts drink and recalculates bac
-(void)addDrink: (NSNumber*)ounces withAlcPercentage: (NSNumber*) percAlc
{
    //NSDAte now: clocks in when the drink was added and timeInterval tells us how many
    //seconds apart from the previous time access it is. The unitsElapsed tells us how many
    //units to shift the BAC graph and arrays with bacValues.
    NSDate *now = [self getHalfHourNow: [NSDate date]];
    [self refreshTimeIndexAround:now];              //give the new xAxis labels
    
    
    
    NSTimeInterval timeInterval = [now timeIntervalSinceDate:_start];
    NSLog(@"%0.2f", timeInterval);
    NSNumber *unitsElapsed = [NSNumber numberWithInt:(int)(timeInterval/halfHr)];
   
    
    
    
        NSLog(@"the number is %@", unitsElapsed);
}


-(double)getBACFromTime: (NSDate*) orig toTime:(NSDate*) curr withAlcPerc: (double)per andOunces: (double)oz
{
    NSTimeInterval timeInterval = [curr timeIntervalSinceDate:orig];
    double hrElapsed = timeInterval/fullHr;
     return (oz / (weight * genderConst) - (.015 * hrElapsed));
}

//rounds time to nearest half hour and returns new NSDATE
-(NSDate*)getHalfHourNow: (NSDate*)curr
{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:curr];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    //rounding logic
    if (minute > 45)
    {
        minute = 0;
        hour += 1;
    }
    else if (minute > 15)
    {
        minute = 30;
    }
    else
    {
        minute = 0;
    }
    
    //Now we set the components to our rounded values
    components.hour = hour;
    components.minute = minute;
    curr = [calendar dateFromComponents:components];
    return curr;
}

//using NSDate, evaluates the hour in INT form and returns it
-(int)getHourIntFromDate: (NSDate*)curr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh"];
    NSMutableString *hours = [[NSMutableString alloc] initWithString:[formatter stringFromDate:curr]];
    NSNumberFormatter * n = [[NSNumberFormatter alloc] init];
    [n setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myHour = [n numberFromString:hours];
    int hr = myHour.doubleValue;
    return hr;
}

//returns minutes in NSDAte in INT form
-(int)getMinuteIntFromDate: (NSDate*)curr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm"];
    
    NSMutableString *minutes = [[NSMutableString alloc] initWithString:[formatter stringFromDate:curr]];
    NSNumberFormatter * n = [[NSNumberFormatter alloc] init];
    [n setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [n numberFromString:minutes];
    int min = myNumber.doubleValue;
    return min;
}


@end
