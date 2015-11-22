//
//  AccountDetailsViewController.m
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/20/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import "AccountDetailsViewController.h"

@interface AccountDetailsViewController ()

@end

@implementation AccountDetailsViewController

static NSString *const cAccountType = @"AccountType";
static NSString *const cClient = @"Client";
static NSString *const cStartDate = @"StartDate";
static NSString *const cEndDate = @"EndDate";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView {
    // Update the user interface for the detail item.
    //self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    //self.navigationItem.leftItemsSupplementBackButton = YES;

    self.pickersDictionary = [[NSMutableDictionary alloc] init];
    [self.pickersDictionary setObject:[self.dataManager loadNames:cAccountType] forKey:cAccountType];
    [self.pickersDictionary setObject:[self.dataManager loadUsersNameSeriaNumber] forKey:cClient];

    if (!self.sAccountType) {
        if ([[self.pickersDictionary objectForKey:cAccountType] count] > 0){
            self.sAccountType = [[self.pickersDictionary objectForKey:cAccountType] firstItem];
            [self.accountType selectRow:[[self.pickersDictionary objectForKey:cAccountType] indexOfObject:self.sAccountType] inComponent:0 animated:NO];
        }
    }
    if (!self.sClient) {
        if ([[self.pickersDictionary objectForKey:cClient] count] > 0){
            self.sClient = [[self.pickersDictionary objectForKey:cClient] firstObject];
            [self.client selectRow:[[self.pickersDictionary objectForKey:cClient]indexOfObject:self.sClient] inComponent:0 animated:NO];
        }
    }


    [self.accountType reloadAllComponents];
    [self.client reloadAllComponents];
}

#pragma - Picker DataSource and Delegate

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([pickerView isEqual:self.startDate]) {
        return [[self.pickersDictionary objectForKey:cStartDate] count];
    } else if ([pickerView isEqual:self.endDate]) {
        return [[self.pickersDictionary objectForKey:cEndDate] count];
    } else if ([pickerView isEqual:self.accountType]){
        return [[self.pickersDictionary objectForKey:cAccountType] count];
    } else if ([pickerView isEqual:self.client]){
        return [[self.pickersDictionary objectForKey:cClient] count];
    }
    return 0;
}

//Delegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if ([pickerView isEqual:self.startDate]) {
        return [[self.pickersDictionary objectForKey:cStartDate] objectAtIndex:row];
    } else if ([pickerView isEqual:self.endDate]) {
        return [[self.pickersDictionary objectForKey:cEndDate] objectAtIndex:row];
    } else if ([pickerView isEqual:self.accountType]){
        return [[self.pickersDictionary objectForKey:cAccountType] objectAtIndex:row];
    } else if ([pickerView isEqual:self.client]){
        return [[self.pickersDictionary objectForKey:cClient] objectAtIndex:row];
    }
    return nil;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if ([pickerView isEqual:self.accountType]) {
        self.sAccountType = [[self.pickersDictionary objectForKey:cAccountType] objectAtIndex:row];
        if (self.sAccountType) {
            AccountType *accountType = [self.dataManager selectAccountTypeWithName:self.sAccountType];
            int r = arc4random() % 100000000;
            self.argeementNumber.text = [NSString stringWithFormat:@"%@%9d",accountType.accountPlan.code, r];
            self.duration.text = [NSString stringWithFormat:@"%d", [accountType.durationMonth intValue]];
            self.percent.text = [NSString stringWithFormat:@"%d", [accountType.percent intValue]];
        }
    } else if ([pickerView isEqual:self.startDate]){
        if (self.sAccountType) {
            AccountType *accountType = [self.dataManager selectAccountTypeWithName:self.sAccountType];
            //gather current calendar
            NSCalendar *calendar = [NSCalendar currentCalendar];

            //gather date components from date
            NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.startDate.date];

            //set date components
            [dateComponents setMonth: dateComponents.month + [accountType.durationMonth intValue] % 12];
            [dateComponents setYear: dateComponents.year + [accountType.durationMonth intValue] / 12];

            //save date relative from date
            self.endDate.date = [calendar dateFromComponents:dateComponents];
        }
    }
}


- (IBAction)buttonLoadClick:(UIButton *)sender {

    Account *newAccount = [self getAccountFromUI];

    NSString *result = [self.dataManager addAccount:newAccount];
    if(result){
        [self showAlertWithTitle:@"ERROR" andMessage:result];
        self.detailItem = nil;
    } else {
        self.detailItem = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (Account *)getAccountFromUI {
    Account * account = [NSEntityDescription insertNewObjectForEntityForName:@"Account"
                                                inManagedObjectContext:self.dataManager.managedObjectContext];
    account.type = [self.dataManager selectAccountTypeWithName:self.sAccountType];
    account.agreementNumber = self.argeementNumber.text;
    account.credit = [NSNumber numberWithInt:[self.sum.text intValue]];
    account.debet = [NSNumber numberWithInt:(-1) * [self.sum.text intValue]];
    account.saldo = [NSNumber numberWithInt:0];
    account.isMain = [NSNumber numberWithBool:YES];
    account.startDate = self.startDate.date;
    account.endDate = self.endDate.date;

    return account;
}

@end
