//
//  MenuViewController.m
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/25/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    OperationViewController *controller = (OperationViewController *)[segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"showPhoneDetails"]) {
        controller.isPhone = YES;
    } else if ([[segue identifier] isEqualToString:@"showGetMoneyDetails"]){
        controller.isPhone = NO;
    } else if ([[segue identifier] isEqualToString:@"showBalanceDetails"]){
        controller.isBalance = YES;
    }
    if (self.detailItem) {
        controller.detailItem = self.detailItem;
    } else {
        controller.detailItem = nil;
    }
}

@end
