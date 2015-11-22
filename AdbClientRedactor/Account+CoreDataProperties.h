//
//  Account+CoreDataProperties.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/21/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Account.h"
#import "AccountType.h"

NS_ASSUME_NONNULL_BEGIN

@interface Account (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *agreementNumber;
@property (nullable, nonatomic, retain) NSNumber *credit;
@property (nullable, nonatomic, retain) NSNumber *debet;
@property (nullable, nonatomic, retain) NSDate *endDate;
@property (nullable, nonatomic, retain) NSNumber *isMain;
@property (nullable, nonatomic, retain) NSNumber *saldo;
@property (nullable, nonatomic, retain) NSDate *startDate;
@property (nullable, nonatomic, retain) NSSet<Card *> *card;
@property (nullable, nonatomic, retain) User *user;
@property (nullable, nonatomic, retain) AccountType *type;

@end

@interface Account (CoreDataGeneratedAccessors)

- (void)addCardObject:(Card *)value;
- (void)removeCardObject:(Card *)value;
- (void)addCard:(NSSet<Card *> *)values;
- (void)removeCard:(NSSet<Card *> *)values;

@end

NS_ASSUME_NONNULL_END
