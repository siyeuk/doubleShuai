//
//  YiXiangTranVC.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/1/25.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "YiXiangTranVC.h"

@interface YiXiangTranVC ()

@end

@implementation YiXiangTranVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(closeCurrentvc)]) {
        [self.delegate closeCurrentvc];
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
