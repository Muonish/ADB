//
//  DataManager.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 10/11/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Disability.h"
#import "City.h"
#import "Nationality.h"
#import "FamilyStatus.h"
#import "User.h"
#import "Passport.h"
#import "Account.h"
#import "AccountPlan.h"
#import "AccountType.h"
#import "Currency.h"
#import "Card.h"

@interface DataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (DataManager*)sharedManager;

//////////////Operations with user table///////////////////
- (NSArray *)selectUserByID: (NSString *)ident;
- (User *)selectUserByID: (NSString *)ident exceptUser: (User *)user;
- (NSString *)addUser: (User *)user;
- (NSString *)updateUserByID: (NSString *)userID toNewUser:(User *)newUser;

//////////Operations with additional tables////////////////
- (Disability *)selectDisabilityWithName: (NSString *)name;
- (Nationality *)selectNationalityWithName: (NSString *)name;
- (City *)selectCityWithName: (NSString *)name;
- (FamilyStatus *)selectFamilyStatusWithName: (NSString *)name;
- (NSArray *)loadNames: (NSString*) entytyName;
- (NSArray *)loadUsers;

- (NSString *)addDisabilityWithName: (NSString *)name;
- (NSString *)addNationalityWithName: (NSString *)name;
- (NSString *)addCityWithName: (NSString *)name;
- (NSString *)addFamilyStatusWithName: (NSString *)name;

//////////////Operations with accounts tables///////////////////
- (NSArray *)loadDepositNames;
- (NSArray *)loadCreditNames;
- (NSArray *)loadCredits;
- (AccountType *)selectAccountTypeWithName: (NSString *)name;
- (AccountPlan *)selectAccountPlanWithName: (NSString *)name;
- (Currency *)selectCurrencyWithName: (NSString *)name;
- (NSString *)addAccount: (Account *)account;
- (NSString *)addAccountType: (AccountType *)accountType;
- (NSString *)addCurrencyWithName: (NSString *)name;
- (NSString *)addAccountPlan: (AccountPlan *)accountPlan;
- (NSString *)addDepisitPercents;
- (NSString *)addCreditPercents;

///////////////////Operations with cards////////////////////////
- (NSArray *)loadCards;
- (NSString *)addCard:(Card *)card;
- (NSString *)checkCardNumber:(NSString *)number andPIN:(NSString *)pin;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)dropDataBase;

@end
