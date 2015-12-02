//
//  BindCardViewController.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/25/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"

@interface BindCardViewController : InfoViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *pickersDictionary;
@property (strong, nonatomic) Account *sAccount;

@property (weak, nonatomic) IBOutlet UIPickerView *accountNumber;
@property (weak, nonatomic) IBOutlet UITextField *cardNumber1;
@property (weak, nonatomic) IBOutlet UITextField *cardNumber2;
@property (weak, nonatomic) IBOutlet UITextField *cardNumber3;
@property (weak, nonatomic) IBOutlet UITextField *cardNumber4;

@property (weak, nonatomic) IBOutlet UITextField *pin;

- (IBAction)buttonSaveClick:(UIButton *)sender;

@end
