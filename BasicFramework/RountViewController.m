//
//  RountViewController.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/3/1.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "RountViewController.h"
#import "LSRoundView.h"
@interface RountViewController ()

@property (nonatomic,strong) LSRoundView *roundView;

@end

@implementation RountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.roundView = [[LSRoundView alloc] initWithFrame:CGRectMake(10, 50, SCREEN_W-20, SCREEN_W-20)];
    self.roundView.centerImage = [UIImage imageNamed:@"roundImage"];
    self.roundView.isPlay = YES;
    [self.view addSubview:self.roundView];
    // Do any additional setup after loading the view.
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
