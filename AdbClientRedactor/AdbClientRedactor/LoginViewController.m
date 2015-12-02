//
//  LoginViewController.m
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/25/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString *const cCard = @"Card";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self configureView];
}

- (void)configureView {
    // Update the user interface for the detail item.

    self.pickersDictionary = [[NSMutableDictionary alloc] init];

    NSArray *cards = [self.dataManager loadCards];

    if (cards) {
        [self.pickersDictionary setObject:cards forKey:cCard];
    }

    if (!self.sCard) {
        if ([[self.pickersDictionary objectForKey:cCard] count] > 0){
            self.sCard = [[self.pickersDictionary objectForKey:cCard] firstObject];
            [self.card selectRow:[[self.pickersDictionary objectForKey:cCard] indexOfObject:self.sCard] inComponent:0 animated:NO];
        }
    }

    [self.card reloadAllComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonLoginClick:(UIButton *)sender {
    if (self.pin.text) {
        NSString *loginResult = [self.dataManager checkCardNumber:self.sCard.number andPIN:self.pin.text];
        if (!loginResult) {
            //[self performSegueWithIdentifier:@"showOperation" sender:self];
        } else {
            [self showAlertWithTitle:@"Notification" message:loginResult andHandler:nil];
        }
    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showOperation"]) {
        OperationViewController *controller = (OperationViewController *)[segue destinationViewController];
        if (self.sCard) {
            controller.detailItem = self.sCard;
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
    if ([pickerView isEqual:self.card]) {
        return [[self.pickersDictionary objectForKey:cCard] count];
    }
    return 0;
}

//Delegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if ([pickerView isEqual:self.card]) {
        return [[[self.pickersDictionary objectForKey:cCard] valueForKey:@"number"] objectAtIndex:row];
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if ([pickerView isEqual:self.card]) {
        self.sCard = [[self.pickersDictionary objectForKey:cCard] objectAtIndex:row];
    }
}
@end
