//
//  DepositViewController.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/20/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabViewController.h"
#include "AccountDetailsViewController.h"

@interface DepositViewController : TabViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) AccountDetailsViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
