//
//  HVGameController.h
//  Hexvix
//
//  Created by Christian Dreier on 18.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVRoundView.h"
#import "HVResultView.h"

@interface HVGameController : UIViewController{
    
    NSString *imageName;
    UISegmentedControl *rubbers;
    UISegmentedControl *pens;
    HVResultView *resultView;
    UIButton *btnDone;
}

- (id)initWithImage:(NSString*)img;
//- (void)solve;

@property (nonatomic, strong) HVRoundView *rv;

@end
