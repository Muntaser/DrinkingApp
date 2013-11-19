//
//  Drink.m
//  BAC
//
//  Created by Subash Luitel on 4/5/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import "Drink.h"

@implementation Drink
@synthesize drinkImage;
@synthesize drinkLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
