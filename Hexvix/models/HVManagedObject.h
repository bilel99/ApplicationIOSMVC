//
//  STManagedObject.h
//  702928_Schmerztagebuch
//
//  Created by Christian Dreier on 17.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class HVAppDelegate;

@interface NSManagedObject (HVManagedObject)

+ (HVAppDelegate *) appDelegate;

#pragma mark -
#pragma mark Reflection
+ (NSEntityDescription *)MREntity;
+ (NSFetchRequest *)fetchRequestForEntity;

#pragma mark -
#pragma mark Finders
+ (NSArray *) allObjectswithPredicate: (NSPredicate *) predicate andLimit: (NSUInteger) limit andSortDescriptors: (NSArray *) sortDescriptors;
+ (NSArray *) allObjectswithPredicate: (NSPredicate *) predicate;
+ (NSArray *) allObjectswithPredicate: (NSPredicate *) predicate andLimit: (NSUInteger) limit;
+ (NSArray *) allObjectswithPredicate: (NSPredicate *) predicate andSortDescriptors: (NSArray *) sortDescriptors;
+ (NSArray *) allObjectswithLimit: (NSUInteger) limit andSortDescriptors: (NSArray *) sortDescriptors;
+ (NSArray *) allObjectswithLimit: (NSUInteger) limit;
+ (NSArray *) allObjectswithSortDescriptors: (NSArray *) sortDescriptors;
+ (NSArray *) allMRObjects;

+ (NSManagedObject *)objectWithServerID: (NSNumber *) serverID;
+ (NSManagedObject *)objectWithID: (NSString *) anId;

#pragma mark -
#pragma mark Creators
+ (id)newObject: (NSDictionary *) attributes;
+ (id)newObject: (NSDictionary *) attributes inContext: (NSManagedObjectContext *) context;
+ (id)newObject;
+ (id)newObjectinContext: (NSManagedObjectContext *) context;


@end
