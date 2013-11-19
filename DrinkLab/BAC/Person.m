//
//  Person.m
//  BAC
//
//  Created by Subash Luitel on 4/1/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import "Person.h"

@implementation Person 
@synthesize name = _name;
@synthesize age = _age;
@synthesize userId = _userId;
@synthesize personImage = _personImage;
@synthesize currentBAC = _currentBAC;

-(Person *)init
{
    self = [super init];
    //_name = @"Subash";
    _age = @"23";
    male = YES;
    _userId = 1;
    _personImage = [UIImage imageNamed:@"test.png"];
    return self;
    
}

//-(void)setName
//{
//    self.name = @"Subash";
//}
@end
