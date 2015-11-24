//
//  SettingsViewController.m
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 10/12/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (DataManager*) dataManager {

    if (!_dataManager) {
        _dataManager = [DataManager sharedManager] ;
    }
    return _dataManager;
}

- (IBAction)buttonCloseDayClick:(UIButton *)sender {
    if(![self.dataManager addDepisitPercents]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notification" message:@"Bank day successfully closed."preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)buttonCloseMonthClick:(UIButton *)sender {
    if(![self.dataManager addCreditPercents]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notification" message:@"Month successfully closed."preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonDropDataBase:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Attention!" message:@"Are you sure you want to delete database permanently?" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil]];

    [alert addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.dataManager dropDataBase];
    }]];
    [self presentViewController:alert animated:YES completion:nil];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
