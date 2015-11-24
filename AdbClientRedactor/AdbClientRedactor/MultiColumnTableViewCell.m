//
//  MultiColumnTableViewCell.m
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/24/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import "MultiColumnTableViewCell.h"


@implementation MultiColumnTableViewCell

- (UILabel *)label {
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:label];
    return label;
}

- (UIView *)divider {
    UIView *view = [[UIView alloc] init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:1.0/[[UIScreen mainScreen] scale]]];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:view];
    return view;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.separatorInset = UIEdgeInsetsZero;
    self.layoutMargins = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;

    self.divider1 = [self divider];
    self.divider2 = [self divider];
    self.divider3 = [self divider];
    self.divider4 = [self divider];

    self.number = [self label];
    self.debt = [self label];
    self.percent = [self label];
    self.mainDebt = [self label];
    self.payment = [self label];

    NSDictionary *views = NSDictionaryOfVariableBindings(_number, _debt, _percent, _mainDebt, _payment, _divider1, _divider2, _divider3, _divider4);

    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_number]-2-[_divider1]-2-[_debt(==_number)]-2-[_divider2]-2-[_percent(==_number)]-2-[_divider3]-2-[_mainDebt(==_number)]-2-[_divider4]-2-[_payment(==_number)]-5-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views];
    [self.contentView addConstraints:constraints];

    NSArray *horizontalConstraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_divider1]|" options:0 metrics:nil views:views];
    [self.contentView addConstraints:horizontalConstraints1];
    NSArray *horizontalConstraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_divider2]|" options:0 metrics:nil views:views];
    [self.contentView addConstraints:horizontalConstraints2];
    NSArray *horizontalConstraints3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_divider3]|" options:0 metrics:nil views:views];
    [self.contentView addConstraints:horizontalConstraints3];
    NSArray *horizontalConstraints4 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_divider4]|" options:0 metrics:nil views:views];
    [self.contentView addConstraints:horizontalConstraints4];
    
    return self;
}

@end
