//
//  ReplaceMacro.h
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/1/17.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#ifndef ReplaceMacro_h
#define ReplaceMacro_h

///各种宏文件
//尺寸
#define SCREEN_B [UIScreen mainScreen].bounds
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

//颜色
#define COLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define COLOR_RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]
#define COLORRANDOM COLOR(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,1)

//打印
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif

///weakSelf
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#endif /* ReplaceMacro_h */
