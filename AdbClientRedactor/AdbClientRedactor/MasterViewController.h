//
//  MasterViewController.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 9/28/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "TabViewController.h"

@class DetailViewController;

@interface MasterViewController : TabViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (assign) BOOL isEdit;

@end

