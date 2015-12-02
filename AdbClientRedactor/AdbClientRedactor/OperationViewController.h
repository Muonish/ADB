//
//  OperationViewController.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/25/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"

@interface OperationViewController : InfoViewController

@property (strong, nonatomic) Card *detailItem;
@property (assign) BOOL isPhone;
@property (assign) BOOL isBalance;

@property (weak, nonatomic) IBOutlet UILabel *set1;
@property (weak, nonatomic) IBOutlet UILabel *set2;
@property (weak, nonatomic) IBOutlet UILabel *set3;

@property (weak, nonatomic) IBOutlet UITextField *sum;

@property (weak, nonatomic) IBOutlet UITextField *phone;

@property (weak, nonatomic) IBOutlet UIButton *button;

- (IBAction)buttonClick:(UIButton *)sender;

@end
