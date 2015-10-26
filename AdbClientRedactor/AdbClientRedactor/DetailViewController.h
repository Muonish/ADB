//
//  DetailViewController.h
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 9/28/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "User.h"
#import "Passport.h"
#import "Disability.h"
#import "City.h"
#import "Nationality.h"


@interface DetailViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) User *detailItem;
@property (strong, nonatomic) DataManager *dataManager;


@property (strong, nonatomic) NSMutableDictionary *pickersDictionary;

@property (strong, nonatomic) NSString *sFamilyStatus;
@property (strong, nonatomic) NSString *sNationality;
@property (strong, nonatomic) NSString *sDisability;
@property (strong, nonatomic) NSString *sCity;

@property (strong, nonatomic) IBOutlet UIButton *load;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *middleName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UIDatePicker *dateBirth;
@property (strong, nonatomic) IBOutlet UISegmentedControl *gender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *pensioner;
@property (strong, nonatomic) IBOutlet UIPickerView *familyStatus;
@property (strong, nonatomic) IBOutlet UIPickerView *nationality;
@property (strong, nonatomic) IBOutlet UIPickerView *disability;
@property (strong, nonatomic) IBOutlet UITextField *passportSeria;
@property (strong, nonatomic) IBOutlet UITextField *passportNumber;
@property (strong, nonatomic) IBOutlet UITextField *passportPlace;
@property (strong, nonatomic) IBOutlet UITextField *passportID;
@property (strong, nonatomic) IBOutlet UIDatePicker *passportDate;
@property (strong, nonatomic) IBOutlet UITextField *placeBirth;
@property (strong, nonatomic) IBOutlet UITextField *registrationAddress;
@property (strong, nonatomic) IBOutlet UITextField *livingAddress;
@property (strong, nonatomic) IBOutlet UIPickerView *livingCity;
@property (strong, nonatomic) IBOutlet UITextField *homePhone;
@property (strong, nonatomic) IBOutlet UITextField *mobilePhone;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *placeWork;
@property (strong, nonatomic) IBOutlet UITextField *positionWork;
@property (strong, nonatomic) IBOutlet UITextField *monthlyIncome;


@end

