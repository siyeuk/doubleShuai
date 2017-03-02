//
//  MVVMTableViewDataSource.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/28.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "MVVMTableViewDataSource.h"
#import "MVVMTableViewCell.h"
#import "MVVMCustomModel.h"
@implementation MVVMTableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MVVMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil) {
        cell = [[MVVMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = ((MVVMCustomModel *)(_array[indexPath.row])).title;
    return cell;
}

@end
