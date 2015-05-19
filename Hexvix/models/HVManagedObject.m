//
//  STManagedObject.m
//  702928_Schmerztagebuch
//
//  Created by Christian Dreier on 17.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HVManagedObject.h"
#import "HVAppDelegate.h"


@implementation NSManagedObject (HVManagedObject)

+ (HVAppDelegate *) appDelegate {
	return (HVAppDelegate *)[[UIApplication sharedApplication] delegate];
}


#pragma mark -
#pragma mark Reflection

+ (NSEntityDescription *)MREntity {
	return [[[[self appDelegate] managedObjectModel] entitiesByName] objectForKey: NSStringFromClass(self)];
}

+ (NSFetchRequest *)fetchRequestForEntity {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity: [self MREntity]];
	return fetchRequest;
}

#pragma mark -
#pragma mark Finders


+ (NSArray *) allObjectswithPredicate: (NSPredicate *) predicate andLimit: (NSUInteger) limit andSortDescriptors: (NSArray *) sortDescriptors {
	NSFetchRequest *request = [self fetchRequestForEntity];
	if (predicate != nil) {
		[request setPredicate: predicate];
	}
	
	if (sortDescriptors != nil && [sortDescriptors count] > 0) {
		[request setSortDescriptors: sortDescriptors];
	}
	
	[request setFetchLimit: limit];
   
	
	return [[[self appDelegate] managedObjectContext] executeFetchRequest: request error: nil];
}

+ (NSArray *) allObjectswithPredicate: (NSPredicate *) predicate {
	return [self allObjectswithPredicate: predicate andLimit: 0 andSortDescriptors: nil];
}

+ (NSArray *) allObjectswithPredicate: (NSPredicate *) predicate andLimit: (NSUInteger) limit {
	return [self allObjectswithPredicate: predicate andLimit: limit andSortDescriptors: nil];
}

+ (NSArray *) allObjectswithPredicate: (NSPredicate *) predicate andSortDescriptors: (NSArray *) sortDescriptors {
	return [self allObjectswithPredicate: predicate andLimit: 0 andSortDescriptors: sortDescriptors];
}

+ (NSArray *) allObjectswithLimit: (NSUInteger) limit andSortDescriptors: (NSArray *) sortDescriptors {
	return [self allObjectswithPredicate: nil andLimit: limit andSortDescriptors: sortDescriptors];
}

+ (NSArray *) allObjectswithLimit: (NSUInteger) limit {
	return [self allObjectswithPredicate: nil andLimit: limit andSortDescriptors: nil];
}

+ (NSArray *) allObjectswithSortDescriptors: (NSArray *) sortDescriptors {
	return [self allObjectswithPredicate: nil andLimit: 0 andSortDescriptors: sortDescriptors];
}

+ (NSArray *) allMRObjects {
	return [self allObjectswithPredicate: nil andLimit: 0 andSortDescriptors: nil];
}


+ (id)objectWithServerID: (NSNumber *) serverID {
    
	if (serverID == nil)
		return nil;
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"serverId = %@", serverID ];
	NSArray *objects = [self allObjectswithPredicate: predicate andLimit: 1];
	
	if ([objects count] > 0) {
        id obj = [objects objectAtIndex:0];
        return obj;
	}
	
	return nil;
}


+ (id)objectWithID: (NSString *) anId {
	if (anId == nil)
		return nil;
	NSURL *myURL = [NSURL URLWithString: anId];
	NSManagedObjectID *myId = [[[self appDelegate] persistentStoreCoordinator] managedObjectIDForURIRepresentation: myURL];
	return [[[self appDelegate] managedObjectContext] objectWithID: myId];
}



#pragma mark -
#pragma mark Creators

- (void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues{
	
	NSMutableDictionary *mutableAttributes = [[NSMutableDictionary alloc] initWithDictionary: keyedValues];
	NSObject *oldObject = [mutableAttributes objectForKey: @"id"];
	if (oldObject != nil) {
		[mutableAttributes setObject: oldObject forKey: @"remoteId"];
		[mutableAttributes removeObjectForKey: @"id"];

	}
	[super setValuesForKeysWithDictionary:mutableAttributes];

}

+ (id)newObject: (NSDictionary *) attributes {
	return [self newObject: attributes inContext: nil];
}

+ (id)newObject: (NSDictionary *) attributes inContext: (NSManagedObjectContext *) context {
	NSManagedObjectContext *moc = context ? context : [[self appDelegate] managedObjectContext];
	NSManagedObject *mob = [[self alloc] initWithEntity: [self MREntity] insertIntoManagedObjectContext: moc];
	if (attributes != nil) {
		
		[mob setValuesForKeysWithDictionary: attributes];
	}
	
	return mob;
}


+ (id)newObject {
	return [self newObject: nil inContext: nil];
}

+ (id)newObjectinContext: (NSManagedObjectContext *) context {
	return [self newObject: nil inContext: context];
}

@end
