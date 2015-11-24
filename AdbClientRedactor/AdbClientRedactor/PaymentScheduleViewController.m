//
//  PaymentScheduleViewController.m
//  AdbClientRedactor
//
//  Created by Valeryia Breshko on 11/24/15.
//  Copyright © 2015 Valeria Breshko. All rights reserved.
//

#import "PaymentScheduleViewController.h"

@interface PaymentScheduleViewController ()

@end

@implementation PaymentScheduleViewController

double debet = 0;
double credit = 0;
double mainDebt = 0;
double percentSum = 0;
double payment = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[MultiColumnTableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.separatorColor = [UIColor lightGrayColor];
    self.payments = [[NSMutableDictionary alloc] init];
    [self.payments setObject:[[NSMutableArray alloc] init] forKey:@"Number"];
    [self.payments setObject:[[NSMutableArray alloc] init] forKey:@"Debt"];
    [self.payments setObject:[[NSMutableArray alloc] init] forKey:@"Percent"];
    [self.payments setObject:[[NSMutableArray alloc] init] forKey:@"MainDebt"];
    [self.payments setObject:[[NSMutableArray alloc] init] forKey:@"Payment"];

    if ([self.detailItem.isDiff isEqual:[NSNumber numberWithBool:YES]]) {
        debet = [self.detailItem.debet intValue];
        mainDebt = debet / [self.detailItem.type.durationMonth doubleValue];
        for (int i = 0; i < [self.detailItem.type.durationMonth doubleValue]; i++) {
            percentSum = debet * [self.detailItem.type.percent doubleValue] / 1200.f;
            payment = mainDebt + percentSum;
            [[self.payments objectForKey:@"Number" ] addObject:[NSNumber numberWithInt:i + 1]];
            [[self.payments objectForKey:@"Debt" ] addObject:[NSNumber numberWithInt:debet]];
            [[self.payments objectForKey:@"Percent" ] addObject:[NSNumber numberWithInt:percentSum]];
            [[self.payments objectForKey:@"MainDebt" ] addObject:[NSNumber numberWithInt:mainDebt]];
            [[self.payments objectForKey:@"Payment" ] addObject:[NSNumber numberWithInt:payment]];
            debet = debet - mainDebt;
        }
    } else {
        debet = [self.detailItem.debet doubleValue];

        double j = [self.detailItem.type.percent doubleValue] / 1200.f;
        double p = pow((1 + j), [self.detailItem.type.durationMonth doubleValue]);
        payment = (j * p * debet) / (p - 1);

        mainDebt = 0;
        double mainDebtSum = 0;
        for (int i = 0; i < [self.detailItem.type.durationMonth intValue]; i++) {
            percentSum = (debet - mainDebtSum) * j;
            mainDebt = payment - percentSum;
            [[self.payments objectForKey:@"Number" ] addObject:[NSNumber numberWithInt:i + 1]];
            [[self.payments objectForKey:@"Debt" ] addObject:[NSNumber numberWithInt:debet - mainDebtSum]];
            [[self.payments objectForKey:@"Percent" ] addObject:[NSNumber numberWithInt:percentSum]];
            [[self.payments objectForKey:@"MainDebt" ] addObject:[NSNumber numberWithInt:mainDebt]];
            [[self.payments objectForKey:@"Payment" ] addObject:[NSNumber numberWithInt:payment]];
            mainDebtSum += mainDebt;
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.detailItem.type.durationMonth intValue] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MultiColumnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.number.text = [NSString stringWithFormat:@"№"];
        cell.debt.text = [NSString stringWithFormat:@"Debt"];
        cell.percent.text = [NSString stringWithFormat:@"Percent"];
        cell.mainDebt.text = [NSString stringWithFormat:@"Main debt"];
        cell.payment.text = [NSString stringWithFormat:@"Payment"];
    } else {
        cell.number.text = [NSString stringWithFormat:@"%@",
                        [[self.payments objectForKey:@"Number"] objectAtIndex:(long)indexPath.row - 1]];
        cell.debt.text = [NSString stringWithFormat:@"%@",
                            [[self.payments objectForKey:@"Debt"] objectAtIndex:(long)indexPath.row - 1]];
        cell.percent.text = [NSString stringWithFormat:@"%@",
                            [[self.payments objectForKey:@"Percent"] objectAtIndex:(long)indexPath.row - 1]];
        cell.mainDebt.text = [NSString stringWithFormat:@"%@",
                            [[self.payments objectForKey:@"MainDebt"] objectAtIndex:(long)indexPath.row - 1]];
        cell.payment.text = [NSString stringWithFormat:@"%@",
                            [[self.payments objectForKey:@"Payment"] objectAtIndex:(long)indexPath.row - 1]];
    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
