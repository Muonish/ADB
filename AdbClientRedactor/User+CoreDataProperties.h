//
//  User+CoreDataProperties.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 10/11/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"
#import "Disability.h"
#import "FamilyStatus.h"
#import "City.h"
#import "Nationality.h"
#import "Passport.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *dateOfBirth;
@property (nullable, nonatomic, retain) NSString *eMail;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSNumber *gender;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *livingAddress;
@property (nullable, nonatomic, retain) NSString *middleName;
@property (nullable, nonatomic, retain) NSString *monthlyIncome;
@property (nullable, nonatomic, retain) NSNumber *pensioner;
@property (nullable, nonatomic, retain) NSString *phoneHome;
@property (nullable, nonatomic, retain) NSString *phoneMobile;
@property (nullable, nonatomic, retain) NSString *placeOfBirth;
@property (nullable, nonatomic, retain) NSString *placeOfWork;
@property (nullable, nonatomic, retain) NSString *position;
@property (nullable, nonatomic, retain) NSString *registrationAddress;
@property (nullable, nonatomic, retain) Disability *disability;
@property (nullable, nonatomic, retain) FamilyStatus *familyStatus;
@property (nullable, nonatomic, retain) City *livingCity;
@property (nullable, nonatomic, retain) Nationality *nationality;
@property (nullable, nonatomic, retain) Passport *passport;

@end

NS_ASSUME_NONNULL_END
