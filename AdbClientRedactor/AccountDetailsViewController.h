//
//  AccountDetailsViewController.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/20/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"
#import "PaymentScheduleViewController.h"
#import "Account.h"
#import "AccountPlan.h"
#import "AccountType.h"
#import "Currency.h"

@interface AccountDetailsViewController : InfoViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) Account *detailItem;
@property (assign) BOOL isDeposit;


@property (strong, nonatomic) NSMutableDictionary *pickersDictionary;
@property (strong, nonatomic) NSString *sAccountType;
@property (strong, nonatomic) User *uClient;
@property (strong, nonatomic) NSDate *dDate;

@property (weak, nonatomic) IBOutlet UIPickerView *accountType;
@property (weak, nonatomic) IBOutlet UITextField *accoutTypeText;
@property (weak, nonatomic) IBOutlet UITextField *clientText;
@property (weak, nonatomic) IBOutlet UIPickerView *client;
@property (weak, nonatomic) IBOutlet UITextField *argeementNumber;
@property (weak, nonatomic) IBOutlet UITextField *currency;
@property (weak, nonatomic) IBOutlet UITextField *duration;
@property (weak, nonatomic) IBOutlet UITextField *endDate;
@property (weak, nonatomic) IBOutlet UITextField *startDateText;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDate;
@property (weak, nonatomic) IBOutlet UITextField *percent;
@property (weak, nonatomic) IBOutlet UITextField *sum;
@property (weak, nonatomic) IBOutlet UIButton *buttonLoad;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddType;
@property (weak, nonatomic) IBOutlet UIButton *buttonScedule;
@property (weak, nonatomic) IBOutlet UILabel *creditType;
@property (weak, nonatomic) IBOutlet UISegmentedControl *diffAnnuit;

- (IBAction)buttonLoadClick:(UIButton *)sender;

@end
