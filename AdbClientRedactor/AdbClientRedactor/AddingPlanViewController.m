//
//  AddingPlanViewController.m
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/22/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import "AddingPlanViewController.h"

@interface AddingPlanViewController ()

@end

@implementation AddingPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonSaveClick:(UIButton *)sender {
    AccountPlan *newAccountPlan = [self getAccountPlanFromUI];

    NSString *result = [self.dataManager addAccountPlan:newAccountPlan];
    if(result){
        [self showAlertWithTitle:@"ERROR" andMessage:result];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (AccountPlan *)getAccountPlanFromUI {
    AccountPlan *newAccountPlan = [NSEntityDescription insertNewObjectForEntityForName:@"AccountPlan"
                                                                inManagedObjectContext:self.dataManager.managedObjectContext];

    if([[self.activity titleForSegmentAtIndex:self.activity.selectedSegmentIndex]
        isEqualToString:@"Active"]){
        newAccountPlan.activity = @"active";
    } else {
        newAccountPlan.activity = @"passive";
    }

    newAccountPlan.code = self.code.text;
    newAccountPlan.name = self.name.text;

    if([[self.type titleForSegmentAtIndex:self.type.selectedSegmentIndex]
        isEqualToString:@"Deposit"]){
        newAccountPlan.isDeposit = [NSNumber numberWithBool:YES];
    } else if([[self.type titleForSegmentAtIndex:self.type.selectedSegmentIndex]
               isEqualToString:@"Credit"]){
        newAccountPlan.isDeposit = [NSNumber numberWithBool:NO];;
    } else {
        newAccountPlan.isDeposit = nil;
    }
    return newAccountPlan;
}

@end
