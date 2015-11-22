//
//  Currency+CoreDataProperties.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/21/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Currency.h"

NS_ASSUME_NONNULL_BEGIN

@interface Currency (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<AccountType *> *accountTypes;

@end

@interface Currency (CoreDataGeneratedAccessors)

- (void)addAccountTypesObject:(AccountType *)value;
- (void)removeAccountTypesObject:(AccountType *)value;
- (void)addAccountTypes:(NSSet<AccountType *> *)values;
- (void)removeAccountTypes:(NSSet<AccountType *> *)values;

@end

NS_ASSUME_NONNULL_END
