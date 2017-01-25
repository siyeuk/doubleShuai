//
//  YiXiangTranVC.h
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/1/25.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol backRootVC <NSObject>
@required

- (void)closeCurrentvc;

@end

@interface YiXiangTranVC : UIViewController

@property (nonatomic,weak) id<backRootVC> delegate;

@end
