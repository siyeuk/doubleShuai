//
//  WKWebViewVC.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/23.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "WKWebViewVC.h"
#import "WKWebViewBaidu.h"
#import "WKWebViewJS.h"

@interface WKWebViewVC ()

@end

@implementation WKWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)openBaiDu:(UIButton *)sender {
    [self.navigationController pushViewController:[[WKWebViewVC alloc] init] animated:YES];
}
- (IBAction)jsCheck:(UIButton *)sender {
     [self.navigationController pushViewController:[[WKWebViewJS alloc] init] animated:YES];
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
