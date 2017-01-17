//
//  APPService.m
//  E钢材
//
//  Created by MS on 16/11/11.
//  Copyright © 2016年 lishuangshuai. All rights reserved.
//

#import "APPService.h"


@implementation APPService

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ///键盘初始化
        [self initKeyBoard];

    });
    
    
}

///键盘初始化
+ (void)initKeyBoard{
//    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enable = YES;
//    manager.shouldResignOnTouchOutside = YES;
//    manager.shouldToolbarUsesTextFieldTintColor = YES;
//    manager.enableAutoToolbar = YES;
}
@end
