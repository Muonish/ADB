//
//  AddingTypeViewController.m
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/22/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import "AddingTypeViewController.h"

@interface AddingTypeViewController ()

@end

@implementation AddingTypeViewController

static NSString *const cAccountPlan = @"AccountPlan";
static NSString *const cCurrency = @"Currency";

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
    [self.pickersDictionary setObject:[self.dataManager loadNames:cAccountPlan] forKey:cAccountPlan];
    [self.pickersDictionary setObject:[self.dataManager loadNames:cCurrency] forKey:cCurrency];


    if (self.sAccountPlan) {
        [self.accountPlan selectRow:[[self.pickersDictionary objectForKey:cAccountPlan] indexOfObject:self.sAccountPlan] inComponent:0 animated:NO];
    }
    if (self.sCurrency) {
        [self.currency selectRow:[[self.pickersDictionary objectForKey:cCurrency]indexOfObject:self.sCurrency] inComponent:0 animated:NO];
    }

    [self.accountPlan reloadAllComponents];
    [self.currency reloadAllComponents];
}

- (IBAction)buttonSaveClick:(UIButton *)sender {
    AccountType *newAccountType = [self getAccountTypeFromUI];

    NSString *result = [self.dataManager addAccountType:newAccountType];
    if(result){
        [self showAlertWithTitle:@"ERROR" message:result andHandler:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (AccountType *)getAccountTypeFromUI {
    AccountType * accountType = [NSEntityDescription insertNewObjectForEntityForName:@"AccountType"
                                                      inManagedObjectContext:self.dataManager.managedObjectContext];
    accountType.name = self.name.text;
    accountType.accountPlan = [self.dataManager selectAccountPlanWithName:self.sAccountPlan];
    accountType.durationMonth = [NSNumber numberWithInt:[self.durationMonth.text intValue]];
    accountType.percent = [NSNumber numberWithInt:[self.percent.text intValue]];
    accountType.currency = [self.dataManager selectCurrencyWithName:self.sCurrency];

    NSLog(@"%@ %@ %@ %@ %@ ",accountType.name, accountType.accountPlan.name, accountType.durationMonth, accountType.percent,accountType.currency.name);
    return accountType;
}

- (IBAction)buttonAddCurrencyClick:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"New currency" message:@"Enter new value:" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        NSString* result = [self.dataManager addCurrencyWithName:alert.textFields.firstObject.text];
        if (result){
            [self showAlertWithTitle:@"ERROR" message:result andHandler:nil];
        } else {
            [self configureView];
        }

    }]];


    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Status";
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma - Picker DataSource and Delegate

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([pickerView isEqual:self.accountPlan]) {
        return [[self.pickersDictionary objectForKey:cAccountPlan] count];
    } else if ([pickerView isEqual:self.currency]) {
        return [[self.pickersDictionary objectForKey:cCurrency] count];
    }
    return 0;
}

//Delegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    if ([pickerView isEqual:self.accountPlan]) {
        return [[self.pickersDictionary objectForKey:cAccountPlan] objectAtIndex:row];
    } else if ([pickerView isEqual:self.currency]) {
        return [[self.pickersDictionary objectForKey:cCurrency] objectAtIndex:row];
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if ([pickerView isEqual:self.accountPlan]) {
        self.sAccountPlan = [[self.pickersDictionary objectForKey:cAccountPlan] objectAtIndex:row];
    } else if ([pickerView isEqual:self.currency]) {
        self.sCurrency = [[self.pickersDictionary objectForKey:cCurrency] objectAtIndex:row];
    } 
}

@end
