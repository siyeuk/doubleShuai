//
//  ScrollPictureVC.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/20.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "ScrollPictureVC.h"
#import "ScrollPicView.h"
@interface ScrollPictureVC ()<UIScrollViewDelegate>

@property (nonatomic,strong) ScrollPicView *scrollView;



@end

@implementation ScrollPictureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    // Do any additional setup after loading the view.
}
- (ScrollPicView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[ScrollPicView alloc] initWithFrame:self.view.bounds target:self];
        [_scrollView loadImage:@[@"自由之翼.jpg",@"自由之翼.jpg",@"自由之翼.jpg",@"自由之翼.jpg",@"自由之翼.jpg"]];
    }
    return _scrollView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_scrollView scroll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
