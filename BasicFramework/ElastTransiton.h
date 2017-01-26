//
//  ElastTransiton.h
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/1/26.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,LSSPresentOneTransitionType) {
    LSSPresentOneTransitionTypePresent = 0,//管理present动画
    LSSPresentOneTransitionTypeDismiss///管理dismiss动画
};

@interface ElastTransiton : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(LSSPresentOneTransitionType)type;
- (instancetype)initWithTransitionType:(LSSPresentOneTransitionType)type;

@end
