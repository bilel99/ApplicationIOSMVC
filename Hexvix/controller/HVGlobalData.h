//
//  HVGlobalData.h
//  Hexvix
//
//  Created by Christian Dreier on 13.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HVGlobalData : NSObject

+(HVGlobalData*)sharedGlobals;

@property (nonatomic, strong) NSArray *images;

@end
