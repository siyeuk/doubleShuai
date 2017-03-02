//
//  MVVMTableViewModel.h
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/3/1.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^callBack)(NSMutableArray *array);

@interface MVVMTableViewModel : NSObject

///下拉刷新
- (void)refreshWithCallback:(callBack)callBack;
///上拉加载
- (void)loadMoreWithCallBack:(callBack)callBack;


@end
