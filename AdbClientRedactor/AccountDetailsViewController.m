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

    if (self.isDeposit) {
        self.diffAnnuit.hidden = YES;
        self.buttonScedule.hidden = YES;
        if (self.detailItem) {
            self.accountType.hidden = YES;
            self.accoutTypeText.hidden = NO;
            self.client.hidden = YES;
            self.clientText.hidden = NO;
            self.startDate.hidden = YES;
            self.startDateText.hidden = NO;
            self.buttonLoad.hidden = YES;
            self.buttonAddType.hidden = YES;

            self.accoutTypeText.text = self.detailItem.type.name;
            self.clientText.text = [NSString stringWithFormat:@"%@ %@%@",
                                    self.detailItem.user.lastName,
                                    self.detailItem.user.passport.seria,
                                    self.detailItem.user.passport.number];
            self.argeementNumber.text = self.detailItem.agreementNumber;
            self.currency.text = self.detailItem.type.currency.name;
            self.duration.text = [NSString stringWithFormat:@"%d",
                                  [self.detailItem.type.durationMonth intValue]];

            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self.detailItem.startDate];
            self.startDateText.text = [NSString stringWithFormat:@"Start date: %d.%d.%d",
                                       (int)[components day], (int)[components month], (int)[components year]];
            components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self.detailItem.endDate];
            self.endDate.text =   [NSString stringWithFormat:@"  End date: %d.%d.%d",
                                   (int)[components day], (int)[components month], (int)[components year] ];

            self.percent.text = [NSString stringWithFormat:@"%d", [self.detailItem.type.percent intValue]];
            self.sum.text = [NSString stringWithFormat:@"%d", [self.detailItem.credit intValue]];
        } else {
            self.accountType.hidden = NO;
            self.accoutTypeText.hidden = YES;
            self.client.hidden = NO;
            self.clientText.hidden = YES;
            self.startDate.hidden = NO;
            self.startDateText.hidden = YES;
            self.buttonLoad.hidden = NO;
            self.buttonAddType.hidden = NO;

            [self configureView];
        }
    } else {
        if (self.detailItem) {
            self.accountType.hidden = YES;
            self.accoutTypeText.hidden = NO;
            self.client.hidden = YES;
            self.clientText.hidden = NO;
            self.startDate.hidden = YES;
            self.startDateText.hidden = NO;
            self.buttonLoad.hidden = YES;
            self.buttonAddType.hidden = YES;
            self.creditType.hidden = NO;
            self.diffAnnuit.hidden = YES;
            self.buttonScedule.hidden = NO;

            self.accoutTypeText.text = self.detailItem.type.name;
            self.clientText.text = [NSString stringWithFormat:@"%@ %@%@",
                                    self.detailItem.user.lastName,
                                    self.detailItem.user.passport.seria,
                                    self.detailItem.user.passport.number];
            self.argeementNumber.text = self.detailItem.agreementNumber;
            self.currency.text = self.detailItem.type.currency.name;

            if (self.duration.text){
                self.duration.text = [NSString stringWithFormat:@"%d",
                                      [self.detailItem.type.durationMonth intValue]];
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self.detailItem.startDate];
                self.startDateText.text = [NSString stringWithFormat:@"Start date: %d.%d.%d",
                                           (int)[components day], (int)[components month], (int)[components year]];
                components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self.detailItem.endDate];
                self.endDate.text =   [NSString stringWithFormat:@"  End date: %d.%d.%d",
                                       (int)[components day], (int)[components month], (int)[components year] ];
            }
            self.percent.text = [NSString stringWithFormat:@"%d", [self.detailItem.type.percent intValue]];
            if ([self.detailItem.isDiff isEqual:[NSNumber numberWithBool:YES]]) {
                self.creditType.text = @"Differentiation payment";
            } else {
                self.creditType.text = @"Annuity payment";
            }

            self.sum.text = [NSString stringWithFormat:@"%d", [self.detailItem.debet intValue]];
        } else {
            self.accountType.hidden = NO;
            self.accoutTypeText.hidden = YES;
            self.client.hidden = NO;
            self.clientText.hidden = YES;
            self.startDate.hidden = NO;
            self.startDateText.hidden = YES;
            self.buttonLoad.hidden = NO;
            self.buttonAddType.hidden = NO;
            self.creditType.hidden = YES;
            self.diffAnnuit.hidden = NO;
            self.buttonScedule.hidden = YES;

            [self configureView];
        }

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView {
    // Update the user interface for the detail item.
        
    self.pickersDictionary = [[NSMutableDictionary alloc] init];
    if (self.isDeposit) {
        [self.pickersDictionary setObject:[self.dataManager loadDepositNames] forKey:cAccountType];
    } else {
        [self.pickersDictionary setObject:[self.dataManager loadCreditNames] forKey:cAccountType];
    }
    [self.pickersDictionary setObject:[self.dataManager loadUsers] forKey:cClient];

    if (!self.sAccountType) {
        if ([[self.pickersDictionary objectForKey:cAccountType] count] > 0){
            self.sAccountType = [[self.pickersDictionary objectForKey:cAccountType] firstObject];
            [self.accountType selectRow:[[self.pickersDictionary objectForKey:cAccountType] indexOfObject:self.sAccountType] inComponent:0 animated:NO];
        }
    }
    if (!self.uClient) {
        if ([[self.pickersDictionary objectForKey:cClient] count] > 0){
            self.uClient = [[self.pickersDictionary objectForKey:cClient] firstObject];
            [self.client selectRow:[[self.pickersDictionary objectForKey:cClient]indexOfObject:self.uClient] inComponent:0 animated:NO];
        }
    }
    [self.accountType reloadAllComponents];
    [self.client reloadAllComponents];

}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showSchedule"]) {
        PaymentScheduleViewController *controller = (PaymentScheduleViewController *)[segue destinationViewController];
        if (self.detailItem) {
            controller.detailItem = self.detailItem;
        } else {
            controller.detailItem = nil;
        }
    }
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
    } else if ([pickerView isEqual:self.accountType]){
        return [[self.pickersDictionary objectForKey:cAccountType] objectAtIndex:row];
    } else if ([pickerView isEqual:self.client]){
        User* object = [[self.pickersDictionary objectForKey:cClient] objectAtIndex:row];
        return [NSString stringWithFormat: @"%@ %@%@", object.lastName,
                object.passport.seria, object.passport.number];
    }
    return nil;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if ([pickerView isEqual:self.accountType]) {
        self.sAccountType = [[self.pickersDictionary objectForKey:cAccountType] objectAtIndex:row];
        if (self.sAccountType) {
            AccountType *accountType = [self.dataManager selectAccountTypeWithName:self.sAccountType];
            int r = arc4random() % 1000000000;
            self.argeementNumber.text = [NSString stringWithFormat:@"%@%9d",accountType.accountPlan.code, r];
            self.currency.text = accountType.currency.name;
            self.duration.text = [NSString stringWithFormat:@"%d", [accountType.durationMonth intValue]];
            self.percent.text = [NSString stringWithFormat:@"%d", [accountType.percent intValue]];
        }
    } else if ([pickerView isEqual:self.client]) {
        self.uClient = [[self.pickersDictionary objectForKey:cClient] objectAtIndex:row];
    }
}


- (IBAction)buttonLoadClick:(UIButton *)sender {

    Account *newAccount = [self getAccountFromUI];

    NSString *result = [self.dataManager addAccount:newAccount];
    if(result){
        [self showAlertWithTitle:@"ERROR" message:result andHandler:nil];
        self.detailItem = nil;
    } else {
        self.detailItem = nil;
        NSString *message;
        if (self.isDeposit) {
            message = [NSString stringWithFormat:
                       @"- %d %@ received in cashbox №1010000000001\n- %d %@ transferred to the account number №%@\n- %d %@ received to Fund Development Bank №7327000000001",
                       [newAccount.credit intValue], newAccount.type.currency.name,
                       [newAccount.credit intValue], newAccount.type.currency.name,
                       newAccount.agreementNumber,
                       [newAccount.credit intValue] , newAccount.type.currency.name];
        } else {
            message = [NSString stringWithFormat:
                       @"- %d %@ get from Fund Development Bank №7327000000001\n- %d %@ transferred to the account number №%@\n- %d %@ received to cashbox №1010000000001",
                       [newAccount.debet intValue], newAccount.type.currency.name,
                       [newAccount.debet intValue], newAccount.type.currency.name,
                       newAccount.agreementNumber,
                       [newAccount.debet intValue] , newAccount.type.currency.name];
        }
        [self showAlertWithTitle:@"Accounting entry information" message:message
                      andHandler:^(UIAlertAction * _Nonnull action) {
             [self.navigationController popViewControllerAnimated:YES];
         }];
    }
}

- (Account *)getAccountFromUI {
    Account * account = [NSEntityDescription insertNewObjectForEntityForName:@"Account"
                                                inManagedObjectContext:self.dataManager.managedObjectContext];
    account.type = [self.dataManager selectAccountTypeWithName:self.sAccountType];
    account.agreementNumber = self.argeementNumber.text;

    if (self.isDeposit) {
        account.credit = [NSNumber numberWithInteger:[self.sum.text integerValue]];
        account.debet = [NSNumber numberWithInteger:(-1) * [self.sum.text integerValue]];
    } else {
        account.credit = [NSNumber numberWithInteger:(-1) * [self.sum.text integerValue]];
        account.debet = [NSNumber numberWithInteger:[self.sum.text integerValue]];
        if([[self.diffAnnuit titleForSegmentAtIndex:self.diffAnnuit.selectedSegmentIndex]
            isEqualToString:@"Diff"]){
            account.isDiff = [NSNumber numberWithBool:YES];
        } else {
            account.isDiff = [NSNumber numberWithBool:NO];
        }
    }
    account.saldo = [NSNumber numberWithInt:0];
    account.isMain = [NSNumber numberWithBool:YES];
    account.startDate = self.startDate.date;

    if (self.sAccountType) {
        AccountType *accountType = [self.dataManager selectAccountTypeWithName:self.sAccountType];
        //gather current calendar
        NSCalendar *calendar = [NSCalendar currentCalendar];

        //gather date components from date
        NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.startDate.date];

        //set date components
        [dateComponents setMonth: dateComponents.month + [accountType.durationMonth intValue] % 12];
        [dateComponents setYear: dateComponents.year + [accountType.durationMonth intValue] / 12];

        self.dDate = [calendar dateFromComponents:dateComponents];
    }

    account.endDate = self.dDate;
    if (self.uClient) {
        account.user = self.uClient;
    }
    NSLog(@"%@", account);
    return account;
}

@end
