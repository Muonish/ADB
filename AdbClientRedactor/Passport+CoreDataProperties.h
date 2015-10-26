//
//  Passport+CoreDataProperties.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 10/11/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Passport.h"

NS_ASSUME_NONNULL_BEGIN

@interface Passport (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *dateOfIssue;
@property (nullable, nonatomic, retain) NSString *identNumber;
@property (nullable, nonatomic, retain) NSString *number;
@property (nullable, nonatomic, retain) NSString *placeOfIssue;
@property (nullable, nonatomic, retain) NSString *seria;
@property (nullable, nonatomic, retain) NSManagedObject *user;

@end

NS_ASSUME_NONNULL_END
