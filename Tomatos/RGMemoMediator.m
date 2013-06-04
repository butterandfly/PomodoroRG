//
//  RGMemoMediator.m
//  Tomatos
//
//  Created by Zero on 13-4-17.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGMemoMediator.h"
#import "RGConstant.h"
#import "RGDataCenter.h"
#import "Memo.h"
#import "RGMemoListController.h"
#import "RGMemoController.h"

@interface RGMemoMediator () {
    __weak RGDataCenter *_dataCenter;
}

// * Private functions.

- (void)popView;
- (void)doAction:(NSInteger)actionTag;

@end

@implementation RGMemoMediator

- (id)init {
    self = [super init];
    if (self) {
        _dataCenter = [RGDataCenter sharedDataCenter];
    }
    return self;
}

- (void)leftTopClick:(id)sender {
    // Get the mode tag.
    int modeTag = self.memoController.navigationItem.leftBarButtonItem.tag;
    
    // * If it's edit mode, we change the data.
    if (modeTag == kActionTagEdit) {
        // * Save data.
        Memo *memo = self.memoController.currentMemo;
        memo.info = self.memoController.memoTextView.text;
        [_dataCenter save];
        
        // * Flesh list view.
        NSInteger row = [self.listController.memoArray indexOfObject:memo];
        NSIndexPath *idxPath = [NSIndexPath indexPathForRow:row inSection:0];
        [self.listController.tableView beginUpdates];
        [self.listController.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:idxPath] withRowAnimation:YES];
        [self.listController.tableView endUpdates];
    }
    
    [self popView];
}

- (void)rightTopClick:(id)sender {
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    [self doAction:button.tag];
}

- (void)popView {
    [self.memoController.navigationController popViewControllerAnimated:YES];
}

- (void)doAction:(NSInteger)actionTag {
    // * Create a new memo.
    if (actionTag == kActionTagAdd) {
        // Create.
        Memo *memo = [_dataCenter addMemoWithInfo:self.memoController.memoTextView.text];
        // Add to the array of listController.
        [self.listController.memoArray insertObject:memo atIndex:0];
        // Reflash the table view
        NSIndexPath *idxPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.listController.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:idxPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        // Get out of here.
        [self popView];
    }
    
    // * Remove the memo.
    if (actionTag == kActionTagDelete) {
        // Get memo, and row.
        Memo *memo = self.memoController.currentMemo;
        NSInteger row = [self.listController.memoArray indexOfObject:memo];
        NSIndexPath *idxPath = [NSIndexPath indexPathForRow:row inSection:0];
        // Delete from array, than reflash the tableview.
        [self.listController.memoArray removeObject:memo];
        [self.listController.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:idxPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        // Update dataCenter.
        [_dataCenter deleteDataObject:memo];
        // Get out of here.
        [self popView];
    }
}

@end
