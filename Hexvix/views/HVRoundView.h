//
//  HVRoundView.h
//  Hexvix
//
//  Created by Christian Dreier on 13.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVPaintView.h"

@interface HVRoundView : UIView{
    BOOL paintingActive;
    UIColor *penColor;
}

-(void)activatePainting;
-(void)cancelPainting;

-(void)loadImage:(NSString*)img;

-(void)setPenSmall;
-(void)setPenMedium;
-(void)setPenBig;

-(void)setRubberSmall;
-(void)setRubberMedium;
-(void)setRubberBig;

-(void)resetPaintview;

@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) HVPaintView *paintView;




@end
