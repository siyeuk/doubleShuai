//
//  RuntimeKit.h
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/3/2.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import <Foundation/Foundation.h>

///摘自一篇博客


@interface RuntimeKit : NSObject

/**
 获取类名

 @param class 相应类
 @return 类名
 */
+ (NSString *)fentchClassName:(Class)class;

/**
 获取成员变量

 @param class 成员变量所在的类
 @return 返回成员变量的数组
 */
+ (NSArray *)fentchIvarList:(Class)class;


/**
 获取类的属性列表，包括私有和公有属性，级定义在拓展中的属性

 @param class CLass
 @return 属性列表数组
 */
+ (NSArray *)fentchPropertyList:(Class)class;


/**
 获取类的实例方法列表。getter  setter  对象方法等。但不能获取类方法

 @param class 方法所在得嘞
 @return 该类的方法列表
 */
+ (NSArray *)fentchMethodList:(Class)class;


/**
 获取协议列表

 @param class 实现协议的类
 @return 返回该类实现的协议列表
 */
+ (NSArray *)fentchProtocolList:(Class)class;


/**
 添加新的方法

 @param class 被添加方法的类
 @param methodSel SEL
 @param methodSelImpl 提供IMP的SEL
 */
+ (void)addMethod:(Class)class method:(SEL)methodSel method:(SEL)methodSelImpl;


/**
 方法交换

 @param class 交换方法所在的类
 @param method1 方法1
 @param method2 方法2
 */
+ (void)methodSwap:(Class)class firstMethod:(SEL)method1 seconeMethod:(SEL)method2;






@end
