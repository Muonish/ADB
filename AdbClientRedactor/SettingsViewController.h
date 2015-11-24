//
//  SettingsViewController.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 10/12/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface SettingsViewController : UITableViewController

@property (strong, nonatomic) DataManager *dataManager;

- (IBAction)buttonCloseDayClick:(UIButton *)sender;
- (IBAction)buttonCloseMonthClick:(UIButton *)sender;

@end
