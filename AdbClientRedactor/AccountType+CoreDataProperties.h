//
//  AccountType+CoreDataProperties.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/21/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AccountType.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountType (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *durationMonth;
@property (nullable, nonatomic, retain) NSNumber *percent;
@property (nullable, nonatomic, retain) AccountPlan *accountPlan;
@property (nullable, nonatomic, retain) Currency *currency;
@property (nullable, nonatomic, retain) NSSet<Account *> *accounts;

@end

@interface AccountType (CoreDataGeneratedAccessors)

- (void)addAccountsObject:(Account *)value;
- (void)removeAccountsObject:(Account *)value;
- (void)addAccounts:(NSSet<Account *> *)values;
- (void)removeAccounts:(NSSet<Account *> *)values;

@end

NS_ASSUME_NONNULL_END
