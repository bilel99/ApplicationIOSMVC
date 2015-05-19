//
//  HVPaintView.m
//  Hexvix
//
//  Created by Christian Dreier on 19.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import "HVPaintView.h"
#import <QuartzCore/QuartzCore.h>

@implementation HVPaintView

@synthesize drawingColor, lineWidth, paintingActive;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        paintingActive = YES;
        
        self.drawingColor = [UIColor greenColor];
        self.lineWidth = 15;
        
        self.layer.cornerRadius = self.bounds.size.width/2;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        
        if(![self initContext:self.frame.size]){
            NSLog(@"ERROR INITIALIZING DRAWING CONTEXT");
        }
        
    }
    return self;
}

-(void)reset{
    if(![self initContext:self.frame.size]){
        NSLog(@"ERROR INITIALIZING DRAWING CONTEXT");
    }
    self.paintingActive = YES;
    [self setNeedsDisplay];
}

-(UIImage*)getMask{
    
    //mask is upside down, i need to flip on y axis
    
    CGContextTranslateCTM(maskContext, 0, self.frame.size.height);
    CGContextScaleCTM(maskContext, 1.0, -1.0);
    
    CGImageRef maskCacheImage = CGBitmapContextCreateImage(maskContext);
    CGContextDrawImage(maskContext, self.bounds, maskCacheImage);
    
    CGImageRef cache = CGBitmapContextCreateImage(maskContext);
    
    mask = [UIImage imageWithCGImage:cache];
    CGImageRelease(cache);
    
    return mask;
}

#pragma mark painting code


- (BOOL) initContext:(CGSize)size {
	
	int bitmapByteCount;
	int	bitmapBytesPerRow;
	
	// Declare the number of bytes per row. Each pixel in the bitmap in this
	// example is represented by 4 bytes; 8 bits each of red, green, blue, and
	// alpha.
	bitmapBytesPerRow = (size.width * 4);
	bitmapByteCount = (bitmapBytesPerRow * size.height);
	
	// Allocate memory for image data. This is the destination in memory
	// where any drawing to the bitmap context will be rendered.
	cacheBitmap = malloc( bitmapByteCount );
  	maskBitmap = malloc( bitmapByteCount );
	if (cacheBitmap == NULL || maskBitmap == NULL){
		return NO;
	}
    
    maskContext = CGBitmapContextCreate (maskBitmap, size.width, size.height, 8, bitmapBytesPerRow, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaNoneSkipFirst);

  	cacheContext = CGBitmapContextCreate (cacheBitmap, size.width, size.height, 8, bitmapBytesPerRow, CGColorSpaceCreateDeviceRGB(), kCGBitmapByteOrder32Little|kCGImageAlphaPremultipliedLast);
	return YES;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(paintingActive){
        UITouch *touch = [touches anyObject];
        [self drawToCache:touch];
        [self drawToMask:touch];        
        [self setNeedsDisplay];
    }
}

- (void) drawToCache:(UITouch*)touch {
    
    CGContextSetStrokeColorWithColor(cacheContext, [self.drawingColor CGColor]);
    
    if(self.drawingColor == [UIColor clearColor]){
        CGContextSetBlendMode(cacheContext, kCGBlendModeClear);
    }else{
        CGContextSetBlendMode(cacheContext, kCGBlendModeNormal);
    }
    
    CGContextSetLineCap(cacheContext, kCGLineCapRound);
    CGContextSetLineWidth(cacheContext, self.lineWidth);
    
    CGPoint lastPoint = [touch previousLocationInView:self];
    CGPoint newPoint = [touch locationInView:self];
    
    CGContextMoveToPoint(cacheContext, lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(cacheContext, newPoint.x, newPoint.y);
    CGContextStrokePath(cacheContext);
    
    
    CGRect dirtyPoint1 = CGRectMake(lastPoint.x-10, lastPoint.y-10, 20, 20);
    CGRect dirtyPoint2 = CGRectMake(newPoint.x-10, newPoint.y-10, 20, 20);
    
    [self setNeedsDisplayInRect:CGRectUnion(dirtyPoint1, dirtyPoint2)];

    
    
}


-(void)drawToMask:(UITouch*)touch{
    CGContextSetStrokeColorWithColor(maskContext, [[UIColor whiteColor] CGColor]);

    if(self.drawingColor == [UIColor clearColor]){
        CGContextSetBlendMode(maskContext, kCGBlendModeClear);
    }else{
        CGContextSetBlendMode(maskContext, kCGBlendModeNormal);
    }
   
    CGContextSetLineCap(maskContext, kCGLineCapRound);
    CGContextSetLineWidth(maskContext, self.lineWidth);
    
    CGPoint lastPoint = [touch previousLocationInView:self];
    CGPoint newPoint = [touch locationInView:self];
    
    CGContextMoveToPoint(maskContext, lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(maskContext, newPoint.x, newPoint.y);
    CGContextStrokePath(maskContext);
    
    CGContextSetBlendMode(maskContext, kCGBlendModeNormal);
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void) drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGImageRef cacheImage = CGBitmapContextCreateImage(cacheContext);
    
//    CGImageRef cacheImage = CGBitmapContextCreateImage(maskContext);
    
    CGContextDrawImage(context, self.bounds, cacheImage);
    CGImageRelease(cacheImage);
}

@end
