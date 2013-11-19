//
//  Person.h
//  BAC
//
//  Created by Subash Luitel on 4/1/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject {
    NSString *_name;
    NSString *_age;
    int _userId;
    UIImage *_personImage;
    BOOL male;
    int _currentBAC;
}

@property NSString *name;
@property NSString *age;
@property int userId;
@property UIImage *personImage;
@property int currentBAC;
-(Person *) init;


@end
