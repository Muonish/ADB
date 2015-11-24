//
//  InfoViewController.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/22/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface InfoViewController : UITableViewController

@property (strong, nonatomic) DataManager *dataManager;
@property (strong, nonatomic) UIGestureRecognizer *tapper;

- (void)showAlertWithTitle: (NSString *)title message: (NSString*) message andHandler:(void (^)(UIAlertAction *action))handler;

@end
