//
//  MultiColumnTableViewCell.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/24/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiColumnTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *number;
@property (strong, nonatomic) UILabel *debt;
@property (strong, nonatomic) UILabel *percent;
@property (strong, nonatomic) UILabel *mainDebt;
@property (strong, nonatomic) UILabel *payment;

@property (strong, nonatomic) UIView *divider1;
@property (strong, nonatomic) UIView *divider2;
@property (strong, nonatomic) UIView *divider3;
@property (strong, nonatomic) UIView *divider4;

@end
