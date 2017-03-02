//
//  LSRoundView.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/3/1.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "LSRoundView.h"

#define SRotationDuration 8.0

@interface LSRoundView()

@property (nonatomic,strong) UIImageView *roundImageView;
@property (nonatomic,strong) UIImageView *statuImageView;

@end

@implementation LSRoundView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initRoundView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initRoundView];
    }
    return self;
}
- (void)initRoundView{
    
    CGPoint center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    
    self.clipsToBounds = YES;
    self.userInteractionEnabled = YES;
    
    self.layer.cornerRadius = center.x;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowRadius = 2.0;
    self.layer.shadowOpacity = 0.6;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    
    self.roundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.roundImageView.image = self.centerImage;
    [self addSubview:self.roundImageView];
    
    UIImage *stateImage;
    if (self.isPlay) {
        stateImage = [UIImage imageNamed:@"RoundStart"];
    }else{
        stateImage = [UIImage imageNamed:@"RountPause"];
    }
    
    self.statuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, stateImage.size.width, stateImage.size.height)];
    self.statuImageView.center = center;
    self.statuImageView.image = stateImage;
    [self addSubview:self.statuImageView];
    
    
    ////旋转
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    
    if (self.rotationDuration == 0) {
        self.rotationDuration = SRotationDuration;
    }
    
    rotationAnimation.duration = self.rotationDuration;
    rotationAnimation.repeatCount = FLT_MAX;
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO;//no remove
    
    [self.roundImageView.layer addAnimation:rotationAnimation forKey:@"rotation"];
    
    ///暂停
    if (!self.isPlay) {
        self.layer.speed = 0.0;
    }
    
}
- (void)setCenterImage:(UIImage *)centerImage{
    _centerImage = centerImage;
    self.roundImageView.image = [_centerImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}
- (void)setIsPlay:(BOOL)isPlay{
    _isPlay = isPlay;
    if (self.isPlay) {
        [self startAnimation];
    }else{
        [self pauseAnimation];
    }
}
- (void)startAnimation{
    self.layer.speed = 1.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval pausedTime = [self.layer timeOffset];
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;

    self.statuImageView.image = [UIImage imageNamed:@"RoundStart"];
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.statuImageView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:1.0 animations:^{
                self.statuImageView.alpha = 0;
            }];
        }
    }];
}
- (void)pauseAnimation{
    self.statuImageView.image = [UIImage imageNamed:@"RountPause"];
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.statuImageView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            self.userInteractionEnabled = YES;
            [UIView animateWithDuration:1.0 animations:^{
                self.statuImageView.alpha = 0;
                //暂停
                CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
                self.layer.speed = 0.0;
                self.layer.timeOffset = pausedTime;
            }];
        }
    }];
}
-(void)play
{
    self.isPlay = YES;
}
-(void)pause
{
    self.isPlay = NO;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.isPlay = !self.isPlay;
    if ([self.delegate respondsToSelector:@selector(playStatusUpdate:)]) {
        [self.delegate playStatusUpdate:self.isPlay];
    }
}
@end
