//
//  DataManager.m
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 10/11/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

//static NSString *const cStoreURL = @"file:///Users/Muon/BSUIR/AdbClientRedactor.sqlite";

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (DataManager*) sharedManager {

    static DataManager* manager = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
    });

    return manager;
}
#pragma mark - User table

- (NSString *)addUser: (User *)user {
    NSString *result = [self validateUser:user];
    if(!result) {
        result = [self validateUserPassport:user.passport];
        if (!result) {
            [self saveContext];
            return nil;
        }
    }
    [self.managedObjectContext deleteObject:user];
    [self saveContext];

    return result;
}
- (NSString *)updateUserByID: (NSString *)userID toNewUser:(User *)newUser{
    NSString *result = [self validateUser:newUser];
    if(!result) {
            User *oldUser = [self selectUserByID: userID exceptUser:newUser];
            if(oldUser) {
                oldUser.firstName = newUser.firstName;
                oldUser.middleName = newUser.middleName;
                oldUser.lastName = newUser.lastName;
                oldUser.gender = newUser.gender;
                oldUser.pensioner = newUser.pensioner;
                oldUser.dateOfBirth = newUser.dateOfBirth;
                oldUser.disability = newUser.disability;
                oldUser.nationality = newUser.nationality;
                oldUser.familyStatus = newUser.familyStatus;
                oldUser.passport.seria = newUser.passport.seria;
                oldUser.passport.number = newUser.passport.number;
                oldUser.passport.placeOfIssue = newUser.passport.placeOfIssue;
                oldUser.passport.identNumber = newUser.passport.identNumber;
                oldUser.passport.dateOfIssue = newUser.passport.dateOfIssue;
                oldUser.placeOfBirth = newUser.placeOfBirth;
                oldUser.registrationAddress = newUser.registrationAddress;
                oldUser.livingAddress = newUser.livingAddress;
                oldUser.livingCity = newUser.livingCity;
                oldUser.monthlyIncome = newUser.monthlyIncome;
                oldUser.eMail = newUser.eMail;
                oldUser.phoneHome = newUser.phoneHome;
                oldUser.phoneMobile = newUser.phoneMobile;
                oldUser.placeOfWork = newUser.placeOfWork;
                oldUser.position = newUser.position;

            } else {
                result = @"Can't find old user.";
            }
    }
    [self.managedObjectContext deleteObject:newUser];
    [self saveContext];
    return result;
}

- (NSArray *)selectUserByID: (NSString *)ident{
    NSFetchRequest* request = [[NSFetchRequest alloc] init];

    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"User"
                inManagedObjectContext:self.managedObjectContext];

    NSPredicate* predicate =
    [NSPredicate predicateWithFormat:@"passport.identNumber == %@", ident];

    [request setPredicate:predicate];
    [request setEntity:description];

    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }

    if (resultArray){
        return resultArray;
    } else {
        return nil;
    }
}

- (User *)selectUserByID: (NSString *)ident exceptUser: (User *)user {
    NSArray *result = [self selectUserByID:ident ];

    if (result.count == 2){
        NSNumber *i = [NSNumber numberWithInteger:[result indexOfObject:user]];
        return [result objectAtIndex:[NSNumber numberWithBool:![i boolValue]].integerValue];
    }
    return nil;
}

- (NSString *)validateUser: (User *)user{

    if (!user.firstName || !user.middleName || !user.lastName || !user.dateOfBirth ||
            !user.disability || !user.nationality || !user.familyStatus || !user.passport ||
            !user.passport.seria ||!user.passport.number || !user.passport.placeOfIssue ||
            !user.passport.identNumber || !user.passport.dateOfIssue || !user.placeOfBirth ||
            !user.registrationAddress || !user.livingAddress || !user.livingCity || !user.monthlyIncome) {

        [self.managedObjectContext reset];
        return @"Fill all fields with * sign.";
    }

    if (![self validateName:user.firstName] || ![self validateName:user.middleName] ||
            ![self validateName:user.lastName]) {
        [self.managedObjectContext reset];
        return @"Enter the valid name! (Ivan Ivanovich Ivanov)";
    }

    if (![self validatePassportSeria:user.passport.seria] ||
            ![self validatePassportNumber:user.passport.number] ||
            ![self validatePassportID:user.passport.identNumber]) {
        [self.managedObjectContext reset];
        return @"Enter the valid passport information! (BM 1234567 1234567A123AA1)";
    }

    if (![self validateMonthlyIncome:user.monthlyIncome]) {
        [self.managedObjectContext reset];
        return @"Enter the valid monthly income! (10000000)";
    }

    if (![user.eMail isEqual: @""]){
        if (![self validateEmail:user.eMail]) {
            [self.managedObjectContext reset];
            return @"Enter the valid e-mail! (myemail321@mail.ru)";
        }
    }

    if (![user.phoneHome isEqual: @""]){
        if (![self validatePhone:user.phoneHome]) {
            [self.managedObjectContext reset];
            return @"Enter the valid phone! (+375172345678)";
        }
    }

    if (![user.phoneMobile isEqual:@""]){
        if (![self validatePhone:user.phoneMobile]) {
            [self.managedObjectContext reset];
            return @"Enter the valid phone! (+375297167893)";
        }
    }

    return nil;
}

- (NSString *)validateUserPassport: (Passport *)passport{
    if ([self selectPassportBySeria:passport.seria andNumber:passport.number]) {
        [self.managedObjectContext reset];
        return @"User with this passport seria and number has already exists!";
    }

    if ([self selectPassportByID:passport.identNumber]) {
        [self.managedObjectContext reset];
        return @"User with this personal ID has already exists!";
    }

    return nil;
}


- (Passport *)selectPassportBySeria: (NSString *)seria andNumber:(NSString *)number{
    NSFetchRequest* request = [[NSFetchRequest alloc] init];

    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"Passport"
                inManagedObjectContext:self.managedObjectContext];

    NSPredicate* predicate =
    [NSPredicate predicateWithFormat:@"seria == %@ AND number == %@", seria, number];

    [request setPredicate:predicate];
    [request setEntity:description];

    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }

    if (resultArray.count > 1){
        NSLog(@"%@",resultArray.firstObject);
        return [resultArray firstObject];
    } else {
        return nil;
    }

}

- (Passport *)selectPassportByID: (NSString *)ident{
    NSFetchRequest* request = [[NSFetchRequest alloc] init];

    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"Passport"
                inManagedObjectContext:self.managedObjectContext];

    NSPredicate* predicate =
    [NSPredicate predicateWithFormat:@"identNumber == %@", ident];

    [request setPredicate:predicate];
    [request setEntity:description];

    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }

    if (resultArray.count > 1){
        return [resultArray firstObject];
    } else {
        return nil;
    }
    
}

#pragma mark - Additional tables

- (Disability *)selectDisabilityWithName: (NSString *)name{
    return [self selectFromTableByName:@"Disability" name:name];
}

- (Nationality *)selectNationalityWithName: (NSString *)name{
    return [self selectFromTableByName:@"Nationality" name:name];
}

- (City *)selectCityWithName: (NSString *)name{
    return [self selectFromTableByName:@"City" name:name];
}

- (FamilyStatus *)selectFamilyStatusWithName: (NSString *)name{
    return [self selectFromTableByName:@"FamilyStatus" name:name];
}

- (id)selectFromTableByName: (NSString *)tableName name: (NSString *) targetName{
    NSFetchRequest* request = [[NSFetchRequest alloc] init];

    NSEntityDescription* description =
    [NSEntityDescription entityForName:tableName
                inManagedObjectContext:self.managedObjectContext];

    NSPredicate* predicate =
    [NSPredicate predicateWithFormat:@"name == %@", targetName];

    [request setPredicate:predicate];
    [request setEntity:description];

    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }

    return [resultArray firstObject];
}

- (NSArray *)loadUsersNameSeriaNumber{
    NSFetchRequest *fetch=[[NSFetchRequest alloc] init];
    NSEntityDescription *testEntity=[NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    [fetch setEntity:testEntity];

    NSError *fetchError =  nil;
    NSArray *fetchedObjs = [self.managedObjectContext executeFetchRequest:fetch error:&fetchError];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (User *object in fetchedObjs) {
        [result addObject: [NSString stringWithFormat:@"%@ %@%@",
                            object.lastName, object.passport.seria, object.passport.number]];
    }
    if (fetchError!=nil) {
        NSLog(@" fetchError=%@,details=%@",fetchError,fetchError.userInfo);
        return nil;
    }
    return result;
}

- (NSArray *)loadNames: (NSString*) entytyName{
    NSFetchRequest *fetch=[[NSFetchRequest alloc] init];
    NSEntityDescription *testEntity=[NSEntityDescription entityForName:entytyName inManagedObjectContext:self.managedObjectContext];
    [fetch setEntity:testEntity];

    NSError *fetchError =  nil;
    NSArray *fetchedObjs = [self.managedObjectContext executeFetchRequest:fetch error:&fetchError];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSManagedObject *object in fetchedObjs) {
        [result addObject: [[object valueForKey:@"name"] description]];
    }
    if (fetchError!=nil) {
        NSLog(@" fetchError=%@,details=%@",fetchError,fetchError.userInfo);
        return nil;
    }
    return result;
}

- (NSString *)addDisabilityWithName: (NSString *)name{
    Disability * selected = [self selectDisabilityWithName:name];
    if (selected) {
        return @"This item has already exists.";
    }
    [self addWithName:@"Disability" fieldName:@"name" value:name];
    return nil;
}
- (NSString *)addNationalityWithName: (NSString *)name{
    name = [name capitalizedString];
    if ([self validateName:name]){
        Nationality * selected = [self selectNationalityWithName:name];
        if (selected) {
            return @"This item has already exists.";
        }
        [self addWithName:@"Nationality" fieldName:@"name" value:name];
        return nil;
    } else {
        return @"Invalid name!";
    }
}
- (NSString *)addCityWithName: (NSString *)name{
    name = [name capitalizedString];
    if ([self validateName:name]){
        City * selected = [self selectCityWithName:name];
        if (selected) {
            return @"This item has already exists.";
        }
        [self addWithName:@"City" fieldName:@"name" value:name];
        return nil;
    } else {
        return @"Invalid name!";
    }
}
- (NSString *)addFamilyStatusWithName: (NSString *)name{
    FamilyStatus * selected = [self selectFamilyStatusWithName:name];
    if (selected) {
        return @"This item has already exists.";
    }
    [self addWithName:@"FamilyStatus" fieldName:@"name" value:name];
    return nil;
}

- (void)addWithName: (NSString *)tableName fieldName: (NSString *)fieldName value: (NSString *)value{
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:tableName
                                                                      inManagedObjectContext:self.managedObjectContext];
    [newManagedObject setValue:value forKey:fieldName];
    [self saveContext];
}

#pragma mark - Account tables

- (Account *)selectAccountWithNumber: (NSString *)agreement{
    NSFetchRequest* request = [[NSFetchRequest alloc] init];

    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"Account"
                inManagedObjectContext:self.managedObjectContext];

    NSPredicate* predicate =
    [NSPredicate predicateWithFormat:@"agreementNumber == %@", agreement];

    [request setPredicate:predicate];
    [request setEntity:description];

    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }

    return [resultArray firstObject];
}

- (AccountType *)selectAccountTypeWithName: (NSString *)name{
    return [self selectFromTableByName:@"AccountType" name:name];
}
- (AccountPlan *)selectAccountPlanWithName: (NSString *)name{
    return [self selectFromTableByName:@"AccountPlan" name:name];
}

- (Currency *)selectCurrencyWithName: (NSString *)name{
    return [self selectFromTableByName:@"Currency" name:name];
}

- (NSString *)addCurrencyWithName: (NSString *)name{
    Currency *selected = [self selectCurrencyWithName:name];
    if (selected) {
        return @"This item has already exists.";
    }
    [self addWithName:@"Currency" fieldName:@"name" value:name];
    return nil;
}

- (NSString *)addAccount: (Account *)account{
    NSString *result = [self validateAccount:account];
    if(!result) {
        id selected = [self selectAccountWithNumber:account.agreementNumber];
        if (selected) {
            [self.managedObjectContext deleteObject:account];
            return @"Account with this agreement number has already exists.";
        } else {
            Account * percentAccount = [NSEntityDescription insertNewObjectForEntityForName:@"Account"
                                                              inManagedObjectContext:self.managedObjectContext];
            percentAccount.type = account.type;
            percentAccount.agreementNumber = account.agreementNumber;
            percentAccount.credit = [NSNumber numberWithInt:0];
            percentAccount.debet = [NSNumber numberWithInt:0];
            percentAccount.saldo = [NSNumber numberWithInt:0];
            percentAccount.isMain = [NSNumber numberWithBool:NO];
            percentAccount.startDate = account.startDate;
            percentAccount.endDate = account.endDate;
            [self saveContext];
            return nil;
        }
    }
    [self.managedObjectContext deleteObject:account];
    [self saveContext];

    return result;
}

- (NSString *)addAccountType: (AccountType *)accountType{
    NSString *result = [self validateAccountType:accountType];
    if(!result) {
        id selected = [self selectFromTableByName:@"AccounType" name:accountType.name];
        if (selected ) {
            [self.managedObjectContext deleteObject:accountType];
            return @"Account type with this name has already exists.";
        } else {
            [self saveContext];
            return nil;
        }
    }
    [self.managedObjectContext deleteObject:accountType];
    [self saveContext];

    return result;
}

- (NSString *)addAccountPlan: (AccountPlan *)accountPlan{
    NSString *result = [self validateAccountPlan:accountPlan];
    if(!result) {
        [self saveContext];
        return nil;
    }
    [self.managedObjectContext deleteObject:accountPlan];
    [self saveContext];

    return result;
}

#pragma mark - Validation

- (NSString *)validateAccount: (Account *)account{

    if (!account.agreementNumber || !account.credit || !account.debet || !account.saldo ||
        !account.endDate || !account.startDate || !account.type || !account.user) {

        [self.managedObjectContext reset];
        return @"Fill all fields with * sign.";
    }

    return nil;
}

- (NSString *)validateAccountType: (AccountType *)accountType{

    if (!accountType.durationMonth || !accountType.name || !accountType.percent ||
        !accountType.accountPlan || !accountType.currency) {

        [self.managedObjectContext reset];
        return @"Fill all fields with * sign.";
    }

    if (![self validatePercents:[NSString stringWithFormat:@"%d", [accountType.percent intValue]]]) {
        [self.managedObjectContext reset];
        return @"Enter the valid percents! (1 - 99)";
    }

    return nil;
}

- (NSString *)validateAccountPlan: (AccountPlan *)accountPlan{

    if (!accountPlan.activity || !accountPlan.code || !accountPlan.name) {

        [self.managedObjectContext reset];
        return @"Fill all fields with * sign.";
    }

    if (![self validateAccountPlanCode: accountPlan.code]) {
        [self.managedObjectContext reset];
        return @"Enter the valid code with 4 digits! (1111)";
    }

    NSFetchRequest* request = [[NSFetchRequest alloc] init];

    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"AccountPlan"
                inManagedObjectContext:self.managedObjectContext];

    NSPredicate* predicate =
    [NSPredicate predicateWithFormat:@"code == %@", accountPlan.code];

    [request setPredicate:predicate];
    [request setEntity:description];

    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }

    id selected = [self selectFromTableByName:@"AccountType" name:accountPlan.name];
    if (selected) {
        return  @"Account plan with this name has alresdy exists.";
    }
    
    return nil;
}


- (BOOL)validateName:(NSString*)value
{
    NSString *searchedString = value;
    NSRange   searchedRange = NSMakeRange(0, [searchedString length]);
    NSString *pattern = @"^[A-Z][a-z]+$";
    NSError  *error = nil;

    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
    NSArray* matches = [regex matchesInString:searchedString options:0 range: searchedRange];


    if (matches.count != 1) {
        return NO;
    } else {
        return YES;
    }
}
- (BOOL)validatePassportSeria:(NSString*)value
{
    NSString *searchedString = value;
    NSRange   searchedRange = NSMakeRange(0, [searchedString length]);
    NSString *pattern = @"^[A-Z][A-Z]$";
    NSError  *error = nil;

    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
    NSArray* matches = [regex matchesInString:searchedString options:0 range: searchedRange];


    if (matches.count != 1) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)validatePassportNumber:(NSString*)value
{
    NSString *searchedString = value;
    NSRange   searchedRange = NSMakeRange(0, [searchedString length]);
    NSString *pattern = @"^[0-9]{7}$";
    NSError  *error = nil;

    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
    NSArray* matches = [regex matchesInString:searchedString options:0 range: searchedRange];

    if (matches.count != 1) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)validatePassportID:(NSString*)value
{
    NSString *searchedString = value;
    NSRange   searchedRange = NSMakeRange(0, [searchedString length]);
    NSString *pattern = @"^[1-9]{7}[ABCKEMH][0-9]{3}[A-Z]{2}[0-9]$";
    NSError  *error = nil;

    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
    NSArray* matches = [regex matchesInString:searchedString options:0 range: searchedRange];


    if (matches.count != 1) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)validateMonthlyIncome:(NSString*)value
{
    NSString *searchedString = value;
    NSRange   searchedRange = NSMakeRange(0, [searchedString length]);
    NSString *pattern = @"^[1-9][0-9]*$";
    NSError  *error = nil;

    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
    NSArray* matches = [regex matchesInString:searchedString options:0 range: searchedRange];


    if (matches.count != 1) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)validateAccountPlanCode:(NSString*)value{
    NSString *searchedString = value;
    NSRange   searchedRange = NSMakeRange(0, [searchedString length]);
    NSString *pattern = @"^[0-9][0-9][0-9][0-9]$";
    NSError  *error = nil;

    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
    NSArray* matches = [regex matchesInString:searchedString options:0 range: searchedRange];


    if (matches.count != 1) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)validatePercents:(NSString*)value
{
    NSString *searchedString = value;
    NSRange   searchedRange = NSMakeRange(0, [searchedString length]);
    NSString *pattern = @"^[1-9][0-9]$";
    NSError  *error = nil;

    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
    NSArray* matches = [regex matchesInString:searchedString options:0 range: searchedRange];


    if (matches.count != 1) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)validateEmail:(NSString*)value
{
    NSString *searchedString = value;
    NSRange   searchedRange = NSMakeRange(0, [searchedString length]);
    NSString *pattern = @"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+$";
    NSError  *error = nil;

    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
    NSArray* matches = [regex matchesInString:searchedString options:0 range: searchedRange];


    if (matches.count != 1) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)validatePhone:(NSString*)value
{
    NSString *searchedString = value;
    NSRange   searchedRange = NSMakeRange(0, [searchedString length]);
    NSString *pattern = @"^[+][1-9][0-9]{11}$";
    NSError  *error = nil;

    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
    NSArray* matches = [regex matchesInString:searchedString options:0 range: searchedRange];


    if (matches.count != 1) {
        return NO;
    } else {
        return YES;
    }
}


#pragma mark - Core Data stack

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.muon.AdbClientRedactor" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AdbClientRedactor" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }

    // Create the coordinator and store

    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"AdbClientRedactor.sqlite"];
    //NSURL *storeURL = [[NSURL alloc] init];
    //NSURL *storeURL = [[NSURL alloc] initWithString:cStoreURL];

    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];

        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    }

    return _persistentStoreCoordinator;
}

- (void)dropDataBase {
    [_managedObjectContext lock];
    NSArray *stores = [_persistentStoreCoordinator persistentStores];
    for(NSPersistentStore *store in stores) {
        [_persistentStoreCoordinator removePersistentStore:store error:nil];
        [[NSFileManager defaultManager] removeItemAtPath:store.URL.path error:nil];
    }
    [_managedObjectContext unlock];
    _managedObjectModel    = nil;
    _managedObjectContext  = nil;
    _persistentStoreCoordinator = nil;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
