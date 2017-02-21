//
//  ScrollPicView.h
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/20.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollPicView : UIView

- (id)initWithFrame:(CGRect)frame target:(id<UIScrollViewDelegate>)target;
- (void)loadImage:(NSArray *)array;
- (void)scroll;

@end
