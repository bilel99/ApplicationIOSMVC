//
//  HVPrepareGameController.h
//  Hexvix
//
//  Created by Christian Dreier on 13.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVRoundView.h"


@interface HVPrepareGameController : UIViewController


-(void)loginSuccessfull;

@property (nonatomic, strong) HVRoundView *rv;

@end
