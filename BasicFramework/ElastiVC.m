//
//  ElastiVC.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/1/26.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "ElastiVC.h"
#import "ElastTransiton.h"
#import "ElastToVC.h"
@interface ElastiVC ()<UIViewControllerTransitioningDelegate>

@property (nonatomic,strong) UIButton *button;

@end

@implementation ElastiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.button];
    // Do any additional setup after loading the view.
}
- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.frame = CGRectMake(0, 0, 100, 40);
        _button.backgroundColor = [UIColor orangeColor];
        _button.center = self.view.center;
        [_button setTitle:@"button" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonBeClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}
- (void)buttonBeClicked{
    ElastToVC *toVC = [[ElastToVC alloc] init] ;
    toVC.transitioningDelegate = self;
    toVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:toVC animated:YES completion:nil];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [ElastTransiton transitionWithTransitionType:LSSPresentOneTransitionTypePresent];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [ElastTransiton transitionWithTransitionType:LSSPresentOneTransitionTypeDismiss];
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
