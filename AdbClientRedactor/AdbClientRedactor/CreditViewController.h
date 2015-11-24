//
//  CreditViewController.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/24/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabViewController.h"
#import "AccountDetailsViewController.h"

@interface CreditViewController : TabViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) AccountDetailsViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (assign) BOOL isView;

@end
