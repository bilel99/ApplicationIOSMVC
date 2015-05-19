//
//  HVGlobalData.m
//  Hexvix
//
//  Created by Christian Dreier on 13.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import "HVGlobalData.h"

@implementation HVGlobalData

@synthesize images;

static HVGlobalData *sharedGlobals;

+(HVGlobalData*)sharedGlobals{
    
    if(sharedGlobals == nil){
        sharedGlobals = [[HVGlobalData alloc] init];
        
        
        sharedGlobals.images = [NSArray arrayWithObjects:
                                @"ge-01.jpg",
                                @"ge-02.jpg",
                                @"ge-03.jpg",
                                @"ge-04.jpg",
                                @"ge-05.jpg",
                                @"ge-06.jpg",
                                @"ge-07.jpg",
                                @"ge-08.jpg",
                                @"ge-09.jpg",
                                @"ge-10.jpg",
                                @"ge-11.jpg",
                                @"ge-12.jpg",
                                //@"ge-13.jpg",
//                                @"ge-14.jpg",
//                                @"ge-15.jpg",
//                                @"ge-16.jpg",
//                                @"ge-17.jpg",
//                                @"ge-18.jpg",
//                                @"ge-19.jpg",
//                                @"ge-20.jpg",
                                @"ge-21.jpg",
                                @"ge-22.jpg",
                                @"ge-23.jpg",
                                @"ge-24.jpg",
                                @"ge-25.jpg",
                                @"ge-26.jpg",
                                @"ge-27.jpg",
                                @"ge-28.jpg",
                                @"ge-29.jpg",
                                @"ge-30.jpg",
                                @"ge-31.jpg",
                                nil];
        
        
        
    }
    return sharedGlobals;
}







@end
