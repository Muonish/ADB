//
//  AddingPlanViewController.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/22/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"
#import "AccountPlan.h"

@interface AddingPlanViewController : InfoViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UISegmentedControl *activity;
@property (weak, nonatomic) IBOutlet UISegmentedControl *type;
- (IBAction)buttonSaveClick:(UIButton *)sender;

@end
