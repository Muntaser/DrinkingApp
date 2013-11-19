//
//  UserDatabase.h
//  BAC
//
//  Created by Muntaser Khan on 4/11/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserDatabase : NSManagedObject

@property (nonatomic, retain) NSNumber * abv;
@property (nonatomic, retain) NSString * drinkName;
@property (nonatomic, retain) NSNumber * picture;

@end
