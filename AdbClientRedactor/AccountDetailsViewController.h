//
//  AccountDetailsViewController.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/20/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"
#import "Account.h"
#import "AccountPlan.h"
#import "AccountType.h"
#import "Currency.h"

@interface AccountDetailsViewController : InfoViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) Account *detailItem;

@property (strong, nonatomic) NSMutableDictionary *pickersDictionary;
@property (strong, nonatomic) NSString *sAccountType;
@property (strong, nonatomic) NSString *sClient;

@property (weak, nonatomic) IBOutlet UIPickerView *accountType;
@property (weak, nonatomic) IBOutlet UIPickerView *client;
@property (weak, nonatomic) IBOutlet UITextField *argeementNumber;
@property (weak, nonatomic) IBOutlet UITextField *currency;
@property (weak, nonatomic) IBOutlet UITextField *duration;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDate;
@property (weak, nonatomic) IBOutlet UITextField *percent;
@property (weak, nonatomic) IBOutlet UITextField *sum;

- (IBAction)buttonLoadClick:(UIButton *)sender;

@end
