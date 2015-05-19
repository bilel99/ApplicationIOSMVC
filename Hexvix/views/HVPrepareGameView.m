//
//  HVPrepareGameView.m
//  Hexvix
//
//  Created by Christian Dreier on 13.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import "HVPrepareGameView.h"

@implementation HVPrepareGameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgr.png"]];
        [bg setFrame:CGRectMake(0, 0, 1024, 768)];
        [self addSubview:bg];        
        
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
