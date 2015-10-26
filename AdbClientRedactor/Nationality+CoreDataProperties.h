//
//  Nationality+CoreDataProperties.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 10/11/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Nationality.h"

NS_ASSUME_NONNULL_BEGIN

@interface Nationality (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<User *> *user;

@end

@interface Nationality (CoreDataGeneratedAccessors)

- (void)addUserObject:(User *)value;
- (void)removeUserObject:(User *)value;
- (void)addUser:(NSSet<User *> *)values;
- (void)removeUser:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
