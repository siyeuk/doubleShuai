//
//  LSRoundView.h
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/3/1.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSRountViewDelegate <NSObject>

- (void)playStatusUpdate:(BOOL)playStatus;

@end


@interface LSRoundView : UIView

@property (nonatomic,weak) id<LSRountViewDelegate>delegate;
///背景图片
@property (nonatomic,strong) UIImage *centerImage;

@property (nonatomic,assign) BOOL isPlay;
///转圈速度
@property (nonatomic,assign) CGFloat rotationDuration;

@end
