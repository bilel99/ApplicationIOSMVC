//
//  HVRoundView.m
//  Hexvix
//
//  Created by Christian Dreier on 13.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import "HVRoundView.h"
#import <QuartzCore/QuartzCore.h>

@implementation HVRoundView

@synthesize img, paintView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor grayColor];
        
        paintingActive = NO;
        penColor = [UIColor darkGrayColor];
        
        //only square views
        self.layer.cornerRadius = self.bounds.size.width/2;
        self.layer.masksToBounds = YES;
        
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 540, 540)];
        
        [self addSubview:self.img];
        
        
    }
    return self;
}

-(void)loadImage:(NSString*)newImg{    
    [self.img setImage:[UIImage imageNamed:newImg]];
}

-(void)cancelPainting{
    paintingActive = NO;
    self.paintView.paintingActive = NO;
}

-(void)removePaintView{
    [self.paintView removeFromSuperview];
}

-(void)resetPaintview{
    [self.paintView reset];
    paintingActive = YES;
}

-(void)activatePainting{
    
    self.paintView = [[HVPaintView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.paintView];
    self.paintView.drawingColor = penColor;
    self.paintView.lineWidth = 15;
    
    paintingActive = YES;
    
}

-(void)setPen: (UIColor*) color andSize: (int) size{
    if(paintingActive){
        self.paintView.drawingColor = color;
        self.paintView.lineWidth = size;
    }
}


-(void)setPenSmall{
    [self setPen:penColor andSize:5];
}
-(void)setPenMedium{
    [self setPen:penColor andSize:15];
}
-(void)setPenBig{
    [self setPen:penColor andSize:25];
}



-(void)setRubberSmall{
    [self setPen:[UIColor clearColor] andSize:5];
}
-(void)setRubberMedium{
    [self setPen:[UIColor clearColor] andSize:15];
}
-(void)setRubberBig{
    [self setPen:[UIColor clearColor] andSize:25];
}



@end
