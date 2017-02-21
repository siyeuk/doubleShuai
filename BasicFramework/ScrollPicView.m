//
//  ScrollPicView.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/20.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "ScrollPicView.h"

@interface ScrollPicView()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,strong) NSArray *picArr;

@end

@implementation ScrollPicView
- (id)initWithFrame:(CGRect)frame target:(id<UIScrollViewDelegate>)target{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(SCREEN_W/6, 0, SCREEN_W*2/3, SCREEN_H)];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.clipsToBounds = NO;
        self.scrollView.delegate = target;
        [self addSubview:self.scrollView];
    }
    return self;
}
- (NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}
- (void)loadImage:(NSArray *)array{
    self.picArr = array;
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    int index = 0;
    for (NSString *name in array) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.frame = CGRectMake(SCREEN_W*2/3*index, SCREEN_H/6, SCREEN_W*2/3, SCREEN_H*2/3);
        if (index != 0) {
            CGRect image = imageView.bounds;
            image.size.width =  SCREEN_W * 2 / 3 * 0.2 * (SCREEN_W * 2 / 3 -  fabs(self.scrollView.contentOffset.x - SCREEN_W * 2 / 3 * 1) )/ SCREEN_W * 2 / 3 + 0.8 *SCREEN_W * 2 / 3;
            image.size.height =  SCREEN_W * 2 / 3 * 0.2 * (SCREEN_W * 2 / 3 -  fabs(self.scrollView.contentOffset.x - SCREEN_W * 2 / 3 * 1) )/ SCREEN_W * 2 / 3 + 0.8 *SCREEN_H * 2 / 3;
            imageView.bounds = image;
        }
        [self.scrollView addSubview:imageView];
        [self.imageArr addObject:imageView];
        index++;
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*index, 0);
}


- (void)scroll{
    int index = self.scrollView.contentOffset.x / (SCREEN_W * 2 / 3);
    if (index == 0) {
        for (int i = 0; i < 2; i++) {
            UIImageView *im = self.imageArr[i];
            CGRect image = im.bounds;
            image.size.width =  SCREEN_W * 2 / 3 * 0.2 * (SCREEN_W * 2 / 3 -  fabs(self.scrollView.contentOffset.x - SCREEN_W * 2 / 3 * i) )/ (SCREEN_W * 2 / 3) + 0.8 * SCREEN_W * 2 / 3;
            image.size.height =  SCREEN_H * 2 / 3 * 0.2 * (SCREEN_W * 2 / 3 -  fabs(self.scrollView.contentOffset.x - SCREEN_W * 2 / 3 * i) )/ (SCREEN_W * 2 / 3) + 0.8 * SCREEN_H * 2 / 3;
            im.bounds = image;
        }
    }else if(index == _picArr.count - 1){
        for (int i = index - 1; i < index + 1; i++) {
            UIImageView *im = self.imageArr[i];
            CGRect image = im.bounds;
            image.size.width =  SCREEN_W * 2 / 3 * 0.2 * (SCREEN_W * 2 / 3 -  fabs(self.scrollView.contentOffset.x - SCREEN_W * 2 / 3 * i) )/ (SCREEN_W * 2 / 3) + 0.8 * SCREEN_W * 2 / 3;
            image.size.height =  SCREEN_H * 2 / 3 * 0.2 * (SCREEN_W * 2 / 3 -  fabs(self.scrollView.contentOffset.x - SCREEN_W * 2 / 3 * i) )/ (SCREEN_W * 2 / 3) + 0.8 * SCREEN_H * 2 / 3;
            im.bounds = image;
        }
    }else{
        for (int i = index - 1; i < index + 2; i++) {
            UIImageView *im = self.imageArr[i];
            CGRect image = im.bounds;
            image.size.width =  SCREEN_W * 2 / 3 * 0.2 * (SCREEN_W * 2 / 3 -  fabs(self.scrollView.contentOffset.x - SCREEN_W * 2 / 3 * i) )/ (SCREEN_W * 2 / 3) + 0.8 * SCREEN_W * 2 / 3;
            image.size.height =  SCREEN_H * 2 / 3 * 0.2 * (SCREEN_W * 2 / 3 -  fabs(self.scrollView.contentOffset.x - SCREEN_W * 2 / 3 * i) )/ (SCREEN_W * 2 / 3) + 0.8 * SCREEN_H * 2 / 3;
            im.bounds = image;
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
