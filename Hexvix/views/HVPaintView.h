//
//  HVPaintView.h
//  Hexvix
//
//  Created by Christian Dreier on 19.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HVPaintView : UIView{

    void *cacheBitmap;
    CGContextRef cacheContext;
    
    CGContextRef maskContext;
    void *maskBitmap;
    UIImage* mask;
    
}

- (BOOL) initContext:(CGSize)size;
- (void) drawToCache:(UITouch*)touch;
-(void)drawToMask:(UITouch*)touch;

-(UIImage*)getMask;

-(void)reset;

@property (nonatomic, strong) UIColor *drawingColor;
@property int lineWidth;
@property BOOL paintingActive;

@end
