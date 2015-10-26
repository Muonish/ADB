//
//  City+CoreDataProperties.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 10/11/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "City.h"

NS_ASSUME_NONNULL_BEGIN

@interface City (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *user;

@end

@interface City (CoreDataGeneratedAccessors)

- (void)addUserObject:(NSManagedObject *)value;
- (void)removeUserObject:(NSManagedObject *)value;
- (void)addUser:(NSSet<NSManagedObject *> *)values;
- (void)removeUser:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
