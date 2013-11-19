//
//  RegisteredUsers.h
//  BAC
//
//  Created by Muntaser Khan on 4/11/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RegisteredUsers : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * fullName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSNumber * email;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSNumber * weight;

@end
