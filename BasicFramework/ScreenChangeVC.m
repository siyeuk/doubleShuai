//
//  ScreenChangeVC.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/23.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "ScreenChangeVC.h"

@interface ScreenChangeVC ()
@property (strong, nonatomic) IBOutlet UIView *landscapeView;
@property (strong, nonatomic) IBOutlet UIView *VerticalView;

@property (nonatomic,strong) UIView *currentView;

@end

@implementation ScreenChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self setupView];
}
- (void)setupView{
    UIInterfaceOrientation oritentation = [[UIApplication sharedApplication] statusBarOrientation];
    [_currentView removeFromSuperview];
    if (UIInterfaceOrientationIsPortrait(oritentation)) {
        _currentView = self.VerticalView;
        _currentView.frame = self.view.bounds;
        [self.view addSubview:_currentView];
    }else if (UIInterfaceOrientationIsLandscape(oritentation)){
        _currentView = self.landscapeView;
        _currentView.frame = self.view.bounds;
        [self.view addSubview:_currentView];
    }
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
