//
//  UITableView+LSTableViewPlaceHolder.h
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/23.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSTableViewPlaceHolderDelegate <NSObject>

@required
- (UIView *)makePlaceHoderView;


@optional
- (BOOL)enableScrollWhenPlaceHolderViewShowing;


@end

@interface UITableView (LSTableViewPlaceHolder)
///刷新数据的时候 调用此方法
- (void)ls_reloadData;

@end
