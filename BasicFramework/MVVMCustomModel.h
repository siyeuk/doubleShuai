//
//  MVVMCustomModel.h
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/3/1.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MVVMCustomModel : NSObject

@property (nonatomic,copy) NSString *title;

@end
////MVVMTableViewModel
/////下拉刷新
//- (void)refreshWithCallback:(callBack)callBack;
/////上拉加载
//- (void)loadMoreWithCallBack:(callBack)callBack;

//- (void)refreshWithCallback:(callBack)callBack{
//    ////线程中执行
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        sleep(2);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            ///主线程刷新视图
//            NSMutableArray *dataArr = [NSMutableArray array];
//            for (int i = 0; i<20; i++) {
//                MVVMCustomModel *model = [[MVVMCustomModel alloc] init];
//                model.title = [NSString stringWithFormat:@"---%d---%d-----%d",arc4random()%1000,arc4random()%1000,arc4random()%1000];
//                [dataArr addObject:model];
//            }
//            callBack(dataArr);
//        });
//    });
//}
//- (void)loadMoreWithCallBack:(callBack)callBack{
//    ////后台线程中执行
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        sleep(2);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            ///主线程刷新视图
//            NSMutableArray *dataArr = [NSMutableArray array];
//            for (int i = 0; i<20; i++) {
//                MVVMCustomModel *model = [[MVVMCustomModel alloc] init];
//                model.title = [NSString stringWithFormat:@"---%d---%d-----%d",arc4random()%1000,arc4random()%1000,arc4random()%1000];
//                [dataArr addObject:model];
//            }
//            callBack(dataArr);
//        });
//    });
//}
