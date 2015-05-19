//
//  HVImageProcessor.h
//  Hexvix
//
//  Created by Christian Dreier on 24.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HVImageProcessor : NSObject{
    
    //CFDataRef drawnImageData;
    const UInt8 *drawnPixels;
    
    //CFDataRef targetImageData;
    const UInt8 *targetPixels;
    
    
    int bytesPerPixel;
    
    float correctMarkedTumorPixels;
    float falseMarkedTumorPixels;
    
    float realTumorSize;
    float completeArea;
    
}


-(id)initWithDrawnImage:(UIImage*)drawn andTargetImage: (UIImage*)target;
-(void)process;
-(void)debug;

@property (nonatomic, strong) UIImage *drawn;
@property (nonatomic, strong) UIImage *target;
@property (nonatomic, strong) UIImage *coloredMask;

@property float percentTumorRemoved;
@property float percentGoodTissueRemoved;
@property float percentTumorStillThere;

@end
