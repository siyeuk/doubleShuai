//
//  ScanCodeView.h
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/22.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanCodeView : UIView

- (instancetype)initWithFrame:(CGRect)frame outsideViewLayer:(CALayer *)outsideLayer;
- (void)removeTimer;
@end
