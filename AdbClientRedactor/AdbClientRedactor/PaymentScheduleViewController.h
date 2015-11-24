//
//  PaymentScheduleViewController.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/24/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "MultiColumnTableViewCell.h"

@interface PaymentScheduleViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) Account *detailItem;
@property (strong, nonatomic) NSMutableDictionary *payments;

@end
