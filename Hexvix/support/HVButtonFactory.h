//
//  HVButtonFactory.h
//  Hexvix
//
//  Created by Christian Dreier on 25.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HVButtonFactory : UIButton


+(UIButton*)getButtonWithText:(NSString*) text andPos:(CGPoint)pos;

@end
