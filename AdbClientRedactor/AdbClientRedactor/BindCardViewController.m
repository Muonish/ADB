//
//  BindCardViewController.m
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/25/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import "BindCardViewController.h"

@interface BindCardViewController ()

@end

@implementation BindCardViewController

static NSString *const cAccountNumber = @"AccountNumber";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureView];
}

- (void)configureView {
    // Update the user interface for the detail item.

    self.pickersDictionary = [[NSMutableDictionary alloc] init];

    NSArray *creditAccounts = [self.dataManager loadCredits];

    if (creditAccounts) {

        [self.pickersDictionary setObject:creditAccounts forKey:cAccountNumber];
    }

    if (!self.sAccount) {
        if ([[self.pickersDictionary objectForKey:cAccountNumber] count] > 0){
            self.sAccount = [[self.pickersDictionary objectForKey:cAccountNumber] firstObject];
            [self.accountNumber selectRow:[[self.pickersDictionary objectForKey:cAccountNumber] indexOfObject:self.sAccount] inComponent:0 animated:NO];
        }
    }

    [self.accountNumber reloadAllComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonSaveClick:(UIButton *)sender {
    Card *card = [self getCardFromUI];

    NSString *result = [self.dataManager addCard:card];
    if(result){
        [self showAlertWithTitle:@"ERROR" message:result andHandler:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (Card *)getCardFromUI {
    Card * newCard = [NSEntityDescription insertNewObjectForEntityForName:@"Card"
                                                              inManagedObjectContext:self.dataManager.managedObjectContext];
    newCard.number = [NSString stringWithFormat:@"%@%@%@%@", self.cardNumber1.text,
                      self.cardNumber2.text, self.cardNumber3.text, self.cardNumber4.text];
    NSLog(@"NUMBER!!! %@", newCard.number);
    newCard.numberOfAttempts = [NSNumber numberWithInt:3];
    newCard.password = self.pin.text;
    newCard.account = self.sAccount;

    return newCard;
}

#pragma - Picker DataSource and Delegate

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([pickerView isEqual:self.accountNumber]) {
        return [[self.pickersDictionary objectForKey:cAccountNumber] count];
    }
    return 0;
}

//Delegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    if ([pickerView isEqual:self.accountNumber]) {
        return [[[self.pickersDictionary objectForKey:cAccountNumber] valueForKey:@"agreementNumber"] objectAtIndex:row];
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if ([pickerView isEqual:self.accountNumber]) {
        self.sAccount = [[self.pickersDictionary objectForKey:cAccountNumber] objectAtIndex:row];
        if (self.sAccount) {
            int r = arc4random() % 10000;
            self.cardNumber1.text = [NSString stringWithFormat:@"%04d", r];
            r = arc4random() % 10000;
            self.cardNumber2.text = [NSString stringWithFormat:@"%04d", r];
            r = arc4random() % 10000;
            self.cardNumber3.text = [NSString stringWithFormat:@"%04d", r];
            r = arc4random() % 10000;
            self.cardNumber4.text = [NSString stringWithFormat:@"%04d", r];
        }
    }
}

@end
