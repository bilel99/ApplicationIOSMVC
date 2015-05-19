//
//  HVResultView.h
//  Hexvix
//
//  Created by Christian Dreier on 26.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVImageProcessor.h"

@interface HVResultView : UIView

@property (nonatomic, strong) UILabel *tumorRemoved;
@property (nonatomic, strong) UILabel *tumorRemained;
@property (nonatomic, strong) UILabel *goodTissueRemoved;
@property (nonatomic, strong) UIImageView *res;
- (id)initWithFrame:(CGRect)frame andResult:(HVImageProcessor*)result;
- (void)showResult;

@end
