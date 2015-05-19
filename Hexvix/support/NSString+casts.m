//
//  NSString+casts.m
//  Hexvix
//
//  Created by Christian Dreier on 18.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import "NSString+casts.h"

@implementation NSString (casts)


-(NSNumber *)toNumber{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    return [f numberFromString:self];
}


-(NSArray *)toCharArray{
    
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithCapacity:[self length]];
    for (int i = 0; i < [self length]; i++) {
        [tmp addObject:[NSString stringWithFormat:@"%c", [self characterAtIndex:i ]]];
    }
    return tmp;
}

@end
