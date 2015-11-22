//
//  AddingTypeViewController.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/22/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"

@interface AddingTypeViewController : InfoViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *pickersDictionary;
@property (strong, nonatomic) NSString *sAccountPlan;
@property (strong, nonatomic) NSString *sCurrency;

@property (weak, nonatomic) IBOutlet UIPickerView *accountPlan;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UIPickerView *currency;
@property (weak, nonatomic) IBOutlet UITextField *durationMonth;
@property (weak, nonatomic) IBOutlet UITextField *percent;
- (IBAction)buttonSaveClick:(UIButton *)sender;

- (IBAction)buttonAddCurrencyClick:(UIButton *)sender;
@end
