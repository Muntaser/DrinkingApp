//
//  LogInInfo.h
//  BAC
//
//  Created by Subash Luitel on 4/22/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LogInInfo : NSManagedObject

@property (nonatomic, retain) NSString * isLoggedIn;
@property (nonatomic, retain) NSString * userID;

@end
