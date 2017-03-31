//
//  STCountryNamesViewController.m
//  Stasher
//
//  Created by bhushan on 22/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STCountryNamesViewController.h"

@interface STCountryNamesViewController ()

@end

@implementation STCountryNamesViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andCountryArray:(NSMutableArray*)thisCountryArray
{
    self = [super initWithNibName:@"STCountryNamesViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.countryNamesArray = [[NSMutableArray alloc] initWithArray:thisCountryArray];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.popUpContainerView.clipsToBounds = YES;
    self.popUpContainerView.layer.cornerRadius = 10.0f;
    self.popUpContainerView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.popUpContainerView.layer.borderWidth=1.0f;
    [self.popUpContainerView setBackgroundColor:[UIColor stasherPopUpBGColor]];
    [self.okButton.titleLabel setFont:[UIFont FontGothamRoundedMediumWithSize:13.0f]];
    [self.cancelButton.titleLabel setFont:[UIFont FontGothamRoundedMediumWithSize:13.0f]];
    [self.selectContryLabel setFont:[UIFont FontGothamRoundedMediumWithSize:13.0f]];
    [self.selectContryLabel setTextColor:[UIColor stasherTextColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark ----- Actions

- (IBAction)okButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(countryNamesViewOkPressedWithCountryId:)]) {
         if ([self.countryNamesArray count] > selectedIndexPath.row) {
             [self.delegate countryNamesViewOkPressedWithCountryId:(int)selectedIndexPath.row];
         }
    }
}

- (IBAction)cancelButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(countryNamesViewCancelPressed)]) {
        [self.delegate countryNamesViewCancelPressed];
    }
}

#pragma mark ----- Table Country Names

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.countryNamesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"AddChildResultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if ([self.countryNamesArray count] > indexPath.row) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[[self.countryNamesArray objectAtIndex:indexPath.row] objectForKey:@"country_name"]];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        [cell.textLabel setTextColor:[UIColor stasherTextColor]];
        [cell.textLabel setFont:[UIFont FontGothamRoundedMediumWithSize:13.0f]];
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndexPath = indexPath;
}
@end
