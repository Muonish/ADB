//
//  OperationViewController.m
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/25/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import "OperationViewController.h"

@interface OperationViewController ()

@end

@implementation OperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isPhone) {
        self.set1.text = @"MTS";
        self.set2.text = @"Velcom";
        self.set3.text = @"Life:)";
        [self.button setTitle:@"PAY" forState:UIControlStateNormal];
        self.phone.hidden = NO;
    } else {
        if (self.isBalance) {
            if (self.detailItem) {
                [self showAlertWithTitle:@"Bill" message:
                 [NSString stringWithFormat:@"Date:\n%@\n\nCard number:\n%@\n\nOperation:\ncheck balance\n\nSum:\n%@ BYR\n\n\nThank you!", [NSDate date],self.detailItem.number, self.detailItem.account.debet]
                              andHandler:^(UIAlertAction *action) {
                                  [self.navigationController popViewControllerAnimated:YES];
                              }];
            }
        } else {
            self.set1.text = @"100 000";
            self.set2.text = @"500 000";
            self.set3.text = @"1 000 000";
            [self.button setTitle:@"GET" forState:UIControlStateNormal];
            self.phone.hidden = YES;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClick:(UIButton *)sender {
    if (self.isPhone) {
        int sum = [self.sum.text intValue];
        if (self.detailItem) {
            if ([self.detailItem.account.debet intValue] > sum) {
                self.detailItem.account.debet = [NSNumber numberWithInt:[self.detailItem.account.debet intValue] - sum];
                [self.dataManager saveContext];
                [self showAlertWithTitle:@"Bill" message:
                 [NSString stringWithFormat:@"Date:\n%@\n\nCard number:\n%@\n\nOperation:\npayment\n\nOperator:\nMTS\n\nPhone number:\n%@\n\nSum:\n%d BYR\n\n\nThank you!", [NSDate date], self.detailItem.number, self.phone.text, sum]
                              andHandler:^(UIAlertAction *action) {
                                  [self.navigationController popViewControllerAnimated:YES];
                              }];
            } else {
                [self showAlertWithTitle:@"Notification" message:@"Not enough money!" andHandler:nil];
            }
        }
    } else {
        int sum = [self.sum.text intValue];
        if (self.detailItem) {
            if ([self.detailItem.account.debet intValue] > sum) {
                self.detailItem.account.debet = [NSNumber numberWithInt:[self.detailItem.account.debet intValue] - sum];
                [self.dataManager saveContext];
                [self showAlertWithTitle:@"Bill" message:
                [NSString stringWithFormat:@"Date:\n%@\n\nCard number:\n%@\n\nOperation:\ncash withdrawal\n\n\n\nSum:\n%d BYR\n\n\nThank you!", [NSDate date], self.detailItem.number, sum]
                              andHandler:^(UIAlertAction *action) {
                                  [self.navigationController popViewControllerAnimated:YES];
                              }];

            } else {
                [self showAlertWithTitle:@"Notification" message:@"Not enough money!" andHandler:nil];
            }
        }
    }
}
@end
