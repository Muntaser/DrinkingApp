//
//  BACInfo.h
//  BAC
//
//  Created by Subash Luitel on 4/23/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BACInfo : NSManagedObject

@property (nonatomic, retain) NSNumber * abv;
@property (nonatomic, retain) NSNumber * ounces;
@property (nonatomic, retain) NSDate * timeDrank;

@end
