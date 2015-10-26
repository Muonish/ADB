//
//  DetailViewController.m
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 9/28/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import "DetailViewController.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

static NSString *const cFamilyStatus = @"FamilyStatus";
static NSString *const cDisability = @"Disability";
static NSString *const cNationality = @"Nationality";
static NSString *const cCity = @"City";

- (DataManager*) dataManager {

    if (!_dataManager) {
        _dataManager = [DataManager sharedManager] ;
    }
    return _dataManager;
}

- (void)configureView {
    // Update the user interface for the detail item.
    self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    self.navigationItem.leftItemsSupplementBackButton = YES;

    self.pickersDictionary = [[NSMutableDictionary alloc] init];
    [self.pickersDictionary setObject:[self.dataManager loadNames:cCity] forKey:cCity];
    [self.pickersDictionary setObject:[self.dataManager loadNames:cDisability] forKey:cDisability];
    [self.pickersDictionary setObject:[self.dataManager loadNames:cNationality] forKey:cNationality];
    [self.pickersDictionary setObject:[self.dataManager loadNames:cFamilyStatus] forKey:cFamilyStatus];

    //[self.dateBirth setDate:NSDate dateWithTimeIntervalSinceNow:];
    //[self.passportDate setDate:NSDate dateWithTimeIntervalSinceNow:0];

    if (self.detailItem) {

        self.firstName.text = self.detailItem.firstName;
        self.middleName.text = self.detailItem.middleName;
        self.lastName.text = self.detailItem.lastName;
        [self.dateBirth setDate:self.detailItem.dateOfBirth];
        self.sDisability = self.detailItem.disability.name;
        self.sCity = self.detailItem.livingCity.name;
        self.sNationality = self.detailItem.nationality.name;
        self.sFamilyStatus = self.detailItem.familyStatus.name;
        if ([self.detailItem.gender boolValue] == YES) {
            self.gender.selectedSegmentIndex = 0;
        } else {
            self.gender.selectedSegmentIndex = 1;
        }
        NSLog(@"pensioner %@",self.detailItem.pensioner );
        if ([self.detailItem.pensioner boolValue] == YES) {
            self.pensioner.selectedSegmentIndex = 1;
        } else {
            self.pensioner.selectedSegmentIndex = 0;
        }

        [self.passportDate setDate:self.detailItem.passport.dateOfIssue];
        self.passportID.text = self.detailItem.passport.identNumber;
        self.passportSeria.text = self.detailItem.passport.seria;
        self.passportNumber.text = self.detailItem.passport.number;
        self.passportPlace.text = self.detailItem.passport.placeOfIssue;

        self.placeBirth.text = self.detailItem.placeOfBirth;
        self.registrationAddress.text = self.detailItem.registrationAddress;
        self.livingAddress.text = self.detailItem.livingAddress;
        self.homePhone.text = self.detailItem.phoneHome;
        self.mobilePhone.text = self.detailItem.phoneMobile;
        self.email.text = self.detailItem.eMail;
        self.placeWork.text = self.detailItem.placeOfWork;
        self.positionWork.text = self.detailItem.position;
        self.monthlyIncome.text = self.detailItem.monthlyIncome;

        [self.load addTarget:self action:@selector(editUser:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.load addTarget:self action:@selector(addUser:) forControlEvents:UIControlEventTouchUpInside];
    }

    if (self.sCity) {
        [self.livingCity selectRow:[[self.pickersDictionary objectForKey:cCity] indexOfObject:self.sCity] inComponent:0 animated:NO];
    }
    if (self.sDisability) {
        [self.disability selectRow:[[self.pickersDictionary objectForKey:cDisability]indexOfObject:self.sDisability] inComponent:0 animated:NO];
    }


    [self.livingCity reloadAllComponents];
    [self.disability reloadAllComponents];
    [self.nationality reloadAllComponents];
    [self.familyStatus reloadAllComponents];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self configureView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.familyStatus.delegate = self;

    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)editUser:(UIButton*)sender{
    User *oldUser = self.detailItem;

    User *newUser = [self getUserFromUI];

    NSString *result = [self.dataManager updateUserByID:oldUser.passport.identNumber toNewUser:newUser];
    if(result){
        [self showAlertWithTitle:@"ERROR" andMessage:result];
        self.detailItem = nil;
        return NO;
    } else {
        self.detailItem = nil;
        return YES;
    }
}

- (BOOL)addUser:(UIButton*)sender{

    User *newUser = [self getUserFromUI];

    NSString *result = [self.dataManager addUser:newUser];
    if(result){
        [self showAlertWithTitle:@"ERROR" andMessage:result];
        self.detailItem = nil;
        return NO;
    } else {
        self.detailItem = nil;
        return YES;
    }
}

- (User *)getUserFromUI {
    User * user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                inManagedObjectContext:self.dataManager.managedObjectContext];
    user.firstName = self.firstName.text;
    user.middleName = self.middleName.text;
    user.lastName = self.lastName.text;

    user.dateOfBirth = self.dateBirth.date;
    if([[self.gender titleForSegmentAtIndex:self.gender.selectedSegmentIndex]
        isEqualToString:@"Male"]){
        user.gender = [NSNumber numberWithBool:YES];
    } else {
        user.gender = [NSNumber numberWithBool:NO];
    }

    if([[self.pensioner titleForSegmentAtIndex:self.pensioner.selectedSegmentIndex]
        isEqualToString:@"Pensioner"]){
        user.pensioner = [NSNumber numberWithBool:YES];
    } else {
        user.pensioner = [NSNumber numberWithBool:NO];
    }

    user.disability = [self.dataManager selectDisabilityWithName:self.sDisability];
    user.nationality = [self.dataManager selectNationalityWithName:self.sNationality];
    user.familyStatus = [self.dataManager selectFamilyStatusWithName:self.sFamilyStatus];

    Passport *passport =
    [NSEntityDescription insertNewObjectForEntityForName:@"Passport"
                                  inManagedObjectContext:self.dataManager.managedObjectContext];

    passport.seria = self.passportSeria.text;
    passport.number = [self.passportNumber.text uppercaseString];
    passport.placeOfIssue = self.passportPlace.text;
    passport.identNumber = [self.passportID.text uppercaseString];
    passport.dateOfIssue = self.passportDate.date;
    user.passport = passport;

    user.placeOfBirth = self.placeBirth.text;
    user.registrationAddress = self.registrationAddress.text;
    user.livingAddress = self.livingAddress.text;
    user.livingCity = [self.dataManager selectCityWithName:self.sCity];
    user.phoneHome = self.homePhone.text;
    user.phoneMobile = self.mobilePhone.text;
    user.eMail = self.email.text;

    user.placeOfWork = self.placeWork.text;
    user.position = self.positionWork.text;
    user.monthlyIncome = self.monthlyIncome.text;

    return user;
}

#pragma - Picker DataSource and Delegate

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([pickerView isEqual:self.livingCity]) {
        return [[self.pickersDictionary objectForKey:cCity] count];
    } else if ([pickerView isEqual:self.familyStatus]) {
        return [[self.pickersDictionary objectForKey:cFamilyStatus] count];
    } else if ([pickerView isEqual:self.disability]) {
        return [[self.pickersDictionary objectForKey:cDisability] count];
    } else if ([pickerView isEqual:self.nationality]) {
        return [[self.pickersDictionary objectForKey:cNationality] count];
    }
    return 0;
}

//Delegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if ([pickerView isEqual:self.livingCity]) {
        return [[self.pickersDictionary objectForKey:cCity] objectAtIndex:row];
    } else if ([pickerView isEqual:self.familyStatus]) {
        return [[self.pickersDictionary objectForKey:cFamilyStatus] objectAtIndex:row];
    } else if ([pickerView isEqual:self.disability]) {
        return [[self.pickersDictionary objectForKey:cDisability] objectAtIndex:row];
    } else if ([pickerView isEqual:self.nationality]) {
        return [[self.pickersDictionary objectForKey:cNationality] objectAtIndex:row];
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if ([pickerView isEqual:self.livingCity]) {
        self.sCity = [[self.pickersDictionary objectForKey:cCity] objectAtIndex:row];
    } else if ([pickerView isEqual:self.familyStatus]) {
        self.sFamilyStatus = [[self.pickersDictionary objectForKey:cFamilyStatus] objectAtIndex:row];
    } else if ([pickerView isEqual:self.disability]) {
        self.sDisability = [[self.pickersDictionary objectForKey:cDisability] objectAtIndex:row];
    } else if ([pickerView isEqual:self.nationality]) {
        self.sNationality = [[self.pickersDictionary objectForKey:cNationality] objectAtIndex:row];
    }
}

#pragma mark - Buttons Add

- (IBAction)buttonAddFamilyStatus:(UIButton *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"New family status" message:@"Enter new value:" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        NSString* result = [self.dataManager addFamilyStatusWithName:alert.textFields.firstObject.text];
        if (result){
            [self showAlertWithTitle:@"ERROR" andMessage:result];
        } else {
            [self configureView];
        }
        
    }]];


    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Status";
    }];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)buttonNationalityStatus:(UIButton *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"New nationality" message:@"Enter new value:" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        NSString* result = [self.dataManager addNationalityWithName:alert.textFields.firstObject.text];
        if (result){
            [self showAlertWithTitle:@"ERROR" andMessage:result];
        } else {
            [self configureView];
        }

    }]];


    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Nationality";
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)buttonDisabilityStatus:(UIButton *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"New disability" message:@"Enter new value:" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString* result = [self.dataManager addDisabilityWithName:alert.textFields.firstObject.text];
        if (result){
            [self showAlertWithTitle:@"ERROR" andMessage:result];
        } else {
            [self configureView];
        }
    }]];


    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Disability";
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)buttonCityStatus:(UIButton *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"New city" message:@"Enter new value:" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        NSString* result = [self.dataManager addCityWithName:alert.textFields.firstObject.text];
        if (result){
            [self showAlertWithTitle:@"ERROR" andMessage:result];
        } else {
            [self configureView];
        }

    }]];


    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Minsk";
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showAlertWithTitle: (NSString *)title andMessage: (NSString*) message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
