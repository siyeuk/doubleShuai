//
//  AlertViewVC.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/27.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "AlertViewVC.h"

#import "JCAlertView.h"

@interface AlertViewVC ()

@end

@implementation AlertViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)one:(id)sender {
    [JCAlertView showOneButtonWithTitle:@"title" Message:@"oneMessage" ButtonType:JCAlertViewButtonTypeWarn ButtonTitle:@"sure" Click:^{
        
        
        [JCAlertView showTwoButtonsWithTitle:@"title" Message:@"twoMessage" ButtonType:
         
         
         JCAlertViewButtonTypeDefault ButtonTitle:@"one" Click:^{
            [JCAlertView showMultipleButtonsWithTitle:@"title" Message:@"moreMessage" Click:^(NSInteger index) {
                NSLog(@"%ldButtonBeClicked",index);
            } Buttons:@{@(JCAlertViewButtonTypeDefault):@"one"},@{@(JCAlertViewButtonTypeCancel):@"two"},@{@(JCAlertViewButtonTypeWarn):@"three"}, nil];
             
             
             
        } ButtonType:JCAlertViewButtonTypeCancel ButtonTitle:@"two" Click:^{
            NSLog(@"twoButtonBeClicked");
        }];
    
        
    }];
}
- (IBAction)two:(id)sender {

}
- (IBAction)three:(id)sender {
 
}
- (IBAction)four:(id)sender {
}
- (IBAction)tive:(id)sender {
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
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
