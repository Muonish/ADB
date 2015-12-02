//
//  LoginViewController.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/25/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"
#import "OperationViewController.h"

@interface LoginViewController : InfoViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *pickersDictionary;
@property (strong, nonatomic) Card *sCard;

@property (weak, nonatomic) IBOutlet UIPickerView *card;
@property (weak, nonatomic) IBOutlet UITextField *pin;
- (IBAction)buttonLoginClick:(UIButton *)sender;

@end
