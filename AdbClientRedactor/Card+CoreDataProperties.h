//
//  Card+CoreDataProperties.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/21/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface Card (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *number;
@property (nullable, nonatomic, retain) NSNumber *numberOfAttempts;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) Account *account;

@end

NS_ASSUME_NONNULL_END
