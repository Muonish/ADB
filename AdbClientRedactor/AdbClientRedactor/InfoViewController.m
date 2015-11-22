//
//  InfoViewController.m
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/22/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (DataManager*) dataManager {

    if (!_dataManager) {
        _dataManager = [DataManager sharedManager] ;
    }
    return _dataManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    self.tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:self.tapper];
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlertWithTitle: (NSString *)title andMessage: (NSString*) message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
