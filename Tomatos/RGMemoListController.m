//
//  RGMemoListController.m
//  Tomatos
//
//  Created by Zero on 13-4-16.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGMemoListController.h"
#import "RGConstant.h"
#import "RGDataCenter.h"

@interface RGMemoListController () {
    __weak RGDataCenter *_dataCenter;
}

@end

@implementation RGMemoListController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _dataCenter = [RGDataCenter sharedDataCenter];
    // Set up memo list.
    self.memoArray = [NSMutableArray arrayWithArray:_dataCenter.allMemo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *addMemoSegue = @"AddMemo";
    NSString *editMemoSegue = @"EditMemo";
    
    NSString *segueId = segue.identifier;
    UIViewController *desContr = segue.destinationViewController;
    // Add mode.
    if ([segueId isEqualToString:addMemoSegue]) {
        [desContr setValue:[NSNumber numberWithInt:kActionTagAdd] forKey:@"actionTag"];
    }
    // Edit mode.
    if ([segueId isEqualToString:editMemoSegue]) {
        [desContr setValue:[NSNumber numberWithInt:kActionTagEdit] forKey:@"actionTag"];
        NSInteger row = [self.tableView indexPathForCell:(UITableViewCell *)sender].row;
        Memo *memo = self.memoArray[row];
        [desContr setValue:memo forKey:@"currentMemo"];
    }
    
    [desContr setValue:self forKey:@"listController"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.memoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MemoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Memo* memo = self.memoArray[indexPath.row];
    cell.textLabel.text = memo.info;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
