//
//  RGHistoryViewController.m
//  Tomatos
//
//  Created by Zero on 13-3-26.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGHistoryViewController.h"
#import "RGDataCenter.h"

@interface RGHistoryViewController () {
    __weak RGDataCenter *_dataCenter;
}

@end

@implementation RGHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Set up UI.
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    // Set up history day list.
    _dataCenter = [RGDataCenter sharedDataCenter];
    self.dateArray = [_dataCenter allDateExceptNewest];
    // Observer the countOfAllDate.
    [_dataCenter addObserver:self forKeyPath:@"countOfAllDate" options:NSKeyValueObservingOptionNew context:NULL];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Push to the RGDayController.
    if ([segue.identifier isEqualToString:@"CheckADay"]) {
        // Get the selected day
        NSInteger row = [[self.tableView indexPathForCell:sender] row];
        UIViewController *des = segue.destinationViewController;
        // Set the date, and inHistory mode.
        [des setValue:self.dateArray[row] forKey:@"currentDay"];
        [des setValue:[NSNumber numberWithBool:YES] forKey:@"inHistory"];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dateArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DateCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Set up the cell.
    Date *aDate = self.dateArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%d)", aDate.dateName, aDate.tomatoCount];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - NSObject methonds

// Observe function.
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // Observe the countOfAllDate.
    if ([keyPath isEqualToString:@"countOfAllDate"]) {
        self.dateArray = [_dataCenter allDateExceptNewest];
        [self.tableView reloadData];
    }
}

@end