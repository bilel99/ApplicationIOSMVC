//
//  HighscoreEntry.h
//  Hexvix
//
//  Created by Christian Dreier on 13.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface HighscoreEntry : NSManagedObject

@property (nonatomic, retain) NSNumber * points;
@property (nonatomic, retain) User *user;

@end
