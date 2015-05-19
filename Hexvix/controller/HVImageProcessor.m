//
//  HVImageProcessor.m
//  Hexvix
//
//  Created by Christian Dreier on 24.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import "HVImageProcessor.h"

@implementation HVImageProcessor

@synthesize drawn, target, coloredMask, percentTumorRemoved, percentGoodTissueRemoved, percentTumorStillThere;



-(id)initWithDrawnImage:(UIImage*)drawnImage andTargetImage: (UIImage*)targetImage{
    
    self = [super init];
    
    if(self){
        
        self.drawn = drawnImage;
        self.target = targetImage;
        
        
        bytesPerPixel = 4;
        
        drawnPixels = CFDataGetBytePtr(CGDataProviderCopyData(CGImageGetDataProvider(self.drawn.CGImage)));
        targetPixels = CFDataGetBytePtr(CGDataProviderCopyData(CGImageGetDataProvider(self.target.CGImage))); 
        
        
    }
    
    return self;
}


-(BOOL)checkWithDrawnOnPos:(CGPoint)pos withColorCode:(int)color{
    
    int pixelStartIndex = (pos.x + (pos.y * self.drawn.size.width)) * bytesPerPixel;
    
    //um einen index verschieben da alpha bit vorhanden ist aber geskipped werden muss
    UInt8 redVal = drawnPixels[pixelStartIndex + 1];
    UInt8 greenVal = drawnPixels[pixelStartIndex + 2];
    UInt8 blueVal = drawnPixels[pixelStartIndex + 3];
    

    
    if(redVal == color && blueVal == color && greenVal == color) {
        return YES;
    }
    
    return NO;
}


-(void)process{
    
    correctMarkedTumorPixels = 0;
    falseMarkedTumorPixels = 0;
    
    realTumorSize = 0;
    completeArea = 0;
    
    for(int x = 0; x < self.target.size.width; x++) {
        for(int y = 0; y < self.target.size.height; y++) {
            
            int pixelStartIndex = (x + (y * self.target.size.width)) * bytesPerPixel;
            
            //ohne alpha channel
            
            UInt8 redVal = targetPixels[pixelStartIndex + 0];
            UInt8 greenVal = targetPixels[pixelStartIndex + 1];
            UInt8 blueVal = targetPixels[pixelStartIndex + 2];
            
            //NSLog(@"green: %i red: %i blue: %i", greenVal, redVal, blueVal);
            
            
            //schwarzes pixel, keine markierung erwartet
            if(redVal == 0 && blueVal == 0 && greenVal == 0) {
                completeArea++;
                if(![self checkWithDrawnOnPos:CGPointMake(x, y) withColorCode:0 ]){
                    falseMarkedTumorPixels++;
                }
            }
            
            //weisses pixel, tumor erwartet
            if(redVal == 255 && blueVal == 255 && greenVal == 255) {
                
                realTumorSize++;
                completeArea++;
                
                if([self checkWithDrawnOnPos:CGPointMake(x, y) withColorCode:255 ]){
                    correctMarkedTumorPixels++;
                }
            }
            
            
        }
    }
    
    
    NSLog(@"correct pixels: %f wrong pixels: %f real tumorsize: %f  and the complete area: %f", correctMarkedTumorPixels, falseMarkedTumorPixels, realTumorSize, completeArea);
    
    
    self.percentTumorRemoved = correctMarkedTumorPixels / realTumorSize;
    self.percentGoodTissueRemoved = falseMarkedTumorPixels / (completeArea - realTumorSize );
    self.percentTumorStillThere = (realTumorSize - correctMarkedTumorPixels) / realTumorSize;
    
    //return [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:ret[0]], [NSNumber numberWithInt:ret[1]], nil];
}




-(void)debug{
    
    
    for(int x = 0; x < self.drawn.size.width; x++) {
        for(int y = 0; y < self.drawn.size.height; y++) {
            
            int pixelStartIndex = (x + (y * self.drawn.size.width)) * bytesPerPixel;
            
            //ohne alpha channel?
            //UInt8 alphaVal = pixels[pixelStartIndex]; // can probably ignore this value
            
            UInt8 redVal = drawnPixels[pixelStartIndex + 1];
            UInt8 greenVal = drawnPixels[pixelStartIndex + 2];
            UInt8 blueVal = drawnPixels[pixelStartIndex + 3];
            
            NSLog(@"green: %i red: %i blue: %i", greenVal, redVal, blueVal);
            
//            
//            if(redVal == 0 && blueVal == 0 && greenVal == 0) {
//                [self checkWithDrawnOnPos:CGPointMake(x, y) withColorCode:0 ];
//            }
//            
//            if(redVal == 255 && blueVal == 255 && greenVal == 255) {
//                [self checkWithDrawnOnPos:CGPointMake(x, y) withColorCode:255 ];
//            }
            
            
        }
    }
    
}



@end
