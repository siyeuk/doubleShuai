//
//  ScanCodeView.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/22.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "ScanCodeView.h"
#import <AVFoundation/AVFoundation.h>

///扫描内容的Y值
#define scanContent_Y self.frame.size.height * 0.24
///扫描内容的Y值
#define scanContent_X self.frame.size.width * 0.15

@interface ScanCodeView()

@property (nonatomic,strong) CALayer *baseLayer;
@property (nonatomic,strong) AVCaptureDevice *device;

///扫描动画线
@property (nonatomic,strong) UIImageView *animationLine;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation ScanCodeView

/** 扫描动画线(冲击波) 的高度 */
static CGFloat const animation_line_H = 12;
/** 扫描内容外部View的alpha值 */
static CGFloat const scanBorderOutsideViewAlpha = 0.4;
/** 定时器和动画的时间 */
static CGFloat const timer_animation_Duration = 0.05;


- (instancetype)initWithFrame:(CGRect)frame outsideViewLayer:(CALayer *)outsideLayer{
    if (self = [super initWithFrame:frame]) {
        self.baseLayer = outsideLayer;
        [self setupScanQRCodeEdge];
    }
    return self;
}
////创建扫描边框
- (void)setupScanQRCodeEdge{
    ///扫描内容的创建
    UIView *scanContentView = [[UIView alloc] init];
    CGFloat scanContentViewX = scanContent_X;
    CGFloat scanContentViewY = scanContent_Y;
    CGFloat scanContentViewW = self.bounds.size.width-2*scanContent_X;
    CGFloat scanContentViewH = scanContentViewW;
    scanContentView.frame = CGRectMake(scanContentViewX, scanContentViewY, scanContentViewW, scanContentViewH);
    scanContentView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6].CGColor;
    scanContentView.layer.borderWidth = 0.7f;
    scanContentView.backgroundColor = [UIColor clearColor];
    [self.baseLayer addSublayer:scanContentView.layer];
    
    ///扫描动画添加
    self.animationLine = [[UIImageView alloc] init];
    self.animationLine.image = [UIImage imageNamed:@"QRCodeLine"];
    self.animationLine.frame = CGRectMake(scanContent_X*0.5, scanContentViewY, self.bounds.size.width-scanContent_X, animation_line_H);
    [self.baseLayer addSublayer:self.animationLine.layer];
    
    
    ///添加定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timer_animation_Duration target:self selector:@selector(animationLine) userInfo:nil repeats:YES];
#pragma mark - - - 扫描边角imageView的创建
    // 左上侧的image
    CGFloat margin = 7;
    
    UIImage *left_image = [UIImage imageNamed:@"QRCodeTopLeft"];
    UIImageView *left_imageView = [[UIImageView alloc] init];
    CGFloat left_imageViewX = CGRectGetMinX(scanContentView.frame) - left_image.size.width * 0.5 + margin;
    CGFloat left_imageViewY = CGRectGetMinY(scanContentView.frame) - left_image.size.width * 0.5 + margin;
    CGFloat left_imageViewW = left_image.size.width;
    CGFloat left_imageViewH = left_image.size.height;
    left_imageView.frame = CGRectMake(left_imageViewX, left_imageViewY, left_imageViewW, left_imageViewH);
    left_imageView.image = left_image;
    [self.baseLayer addSublayer:left_imageView.layer];
    
    // 右上侧的image
    UIImage *right_image = [UIImage imageNamed:@"QRCodeTopRight"];
    UIImageView *right_imageView = [[UIImageView alloc] init];
    CGFloat right_imageViewX = CGRectGetMaxX(scanContentView.frame) - right_image.size.width * 0.5 - margin;
    CGFloat right_imageViewY = left_imageView.frame.origin.y;
    CGFloat right_imageViewW = left_image.size.width;
    CGFloat right_imageViewH = left_image.size.height;
    right_imageView.frame = CGRectMake(right_imageViewX, right_imageViewY, right_imageViewW, right_imageViewH);
    right_imageView.image = right_image;
    [self.baseLayer addSublayer:right_imageView.layer];
    
    // 左下侧的image
    UIImage *left_image_down = [UIImage imageNamed:@"QRCodebottomLeft"];
    UIImageView *left_imageView_down = [[UIImageView alloc] init];
    CGFloat left_imageView_downX = left_imageView.frame.origin.x;
    CGFloat left_imageView_downY = CGRectGetMaxY(scanContentView.frame) - left_image_down.size.width * 0.5 - margin;
    CGFloat left_imageView_downW = left_image.size.width;
    CGFloat left_imageView_downH = left_image.size.height;
    left_imageView_down.frame = CGRectMake(left_imageView_downX, left_imageView_downY, left_imageView_downW, left_imageView_downH);
    left_imageView_down.image = left_image_down;
    [self.baseLayer addSublayer:left_imageView_down.layer];
    
    // 右下侧的image
    UIImage *right_image_down = [UIImage imageNamed:@"QRCodebottomRight"];
    UIImageView *right_imageView_down = [[UIImageView alloc] init];
    CGFloat right_imageView_downX = right_imageView.frame.origin.x;
    CGFloat right_imageView_downY = left_imageView_down.frame.origin.y;
    CGFloat right_imageView_downW = left_image.size.width;
    CGFloat right_imageView_downH = left_image.size.height;
    right_imageView_down.frame = CGRectMake(right_imageView_downX, right_imageView_downY, right_imageView_downW, right_imageView_downH);
    right_imageView_down.image = right_image_down;
    [self.baseLayer addSublayer:right_imageView_down.layer];
    
}
#pragma mark - - - 照明灯的点击事件
- (void)light_buttonAction:(UIButton *)button {
    if (button.selected == NO) { // 点击打开照明灯
        [self turnOnLight:YES];
        button.selected = YES;
    } else { // 点击关闭照明灯
        [self turnOnLight:NO];
        button.selected = NO;
    }
}

- (void)turnOnLight:(BOOL)on {
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([_device hasTorch]) {
        [_device lockForConfiguration:nil];
        if (on) {
            [_device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [_device setTorchMode: AVCaptureTorchModeOff];
        }
        [_device unlockForConfiguration];
    }
}
#pragma mark - 执行定时器方法 -
- (void)animationAction{
    __block CGRect frame = _animationLine.frame;
    
    static BOOL flag = YES;
    
    if (flag) {
        frame.origin.y = scanContent_Y;
        flag = NO;
        [UIView animateWithDuration:timer_animation_Duration animations:^{
            frame.origin.y += 5;
            _animationLine.frame = frame;
        } completion:nil];
    } else {
        if (_animationLine.frame.origin.y >= scanContent_Y) {
            CGFloat scanContent_MaxY = scanContent_Y + self.frame.size.width - 2 * scanContent_X;
            if (_animationLine.frame.origin.y >= scanContent_MaxY - 5) {
                frame.origin.y = scanContent_Y;
                _animationLine.frame = frame;
                flag = YES;
            } else {
                [UIView animateWithDuration:timer_animation_Duration animations:^{
                    frame.origin.y += 5;
                    _animationLine.frame = frame;
                } completion:nil];
            }
        } else {
            flag = !flag;
        }
    }
}
#pragma mark - 移除定时器 -
- (void)removeTimer {
    [self.timer invalidate];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
