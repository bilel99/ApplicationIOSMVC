//
//  HVButtonFactory.m
//  Hexvix
//
//  Created by Christian Dreier on 25.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import "HVButtonFactory.h"

@implementation HVButtonFactory



+(UIButton*)getButtonWithText:(NSString*) text andPos:(CGPoint)pos{
    
    UIButton *tmp = [[UIButton alloc] initWithFrame:CGRectMake(pos.x, pos.y, 272, 43)];

    [tmp setBackgroundImage:[UIImage imageNamed:@"btn_active_up_bgr.png"] forState:UIControlStateNormal];
    [tmp setBackgroundImage:[UIImage imageNamed:@"btn_active_down_bgr.png"] forState:UIControlStateHighlighted];
    
    [tmp setTitle:text forState:UIControlStateNormal];
    [tmp.titleLabel setFont:[UIFont boldSystemFontOfSize:22]];
    
    [tmp setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [tmp setTitleColor:[UIColor colorWithRed:6.0f/255.0f green:61.0f/255.0f blue:122.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [tmp setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    return tmp;
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
