//
//  AccountPlan+CoreDataProperties.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/21/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AccountPlan.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountPlan (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *activity;
@property (nullable, nonatomic, retain) NSString *code;
@property (nullable, nonatomic, retain) NSNumber *isDeposit;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *accountTypes;

@end

@interface AccountPlan (CoreDataGeneratedAccessors)

- (void)addAccountTypesObject:(NSManagedObject *)value;
- (void)removeAccountTypesObject:(NSManagedObject *)value;
- (void)addAccountTypes:(NSSet<NSManagedObject *> *)values;
- (void)removeAccountTypes:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
