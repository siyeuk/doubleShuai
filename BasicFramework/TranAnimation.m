//
//  TranAnimation.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/1/25.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "TranAnimation.h"
#import "YiXiangTranVC.h"
@interface TranAnimation ()<UITableViewDelegate,UITableViewDataSource,backRootVC>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) YiXiangTranVC *yinxiang;
@property (nonatomic,assign) CGRect originRect;

@end

@implementation TranAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"印象笔记";
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64) style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = @"cellId";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    self.yinxiang.delegate = self;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    tableView.scrollEnabled = NO;
    self.originRect = [cell convertRect:cell.contentView.frame toView:tableView];
    CGRect nextVCRect = CGRectMake(self.originRect.origin.x, 0, self.originRect.size.width, self.view.frame.size.height);
    
//    NSArray *indexUp = [tableView indexPathsForRowsInRect:CGRectMake(0, 0, tableView.frame.size.width, cell.frame.origin.y)];
//    NSArray *indexDown = [tableView indexPathsForRowsInRect:CGRectMake(0, CGRectGetMaxY(cell.frame), tableView.frame.size.width, CGRectGetHeight(tableView.frame))];
    
    [self addChildViewController:self.yinxiang];
    self.yinxiang.view.frame = self.originRect;
    self.yinxiang.view.alpha = 0;
    [self.view addSubview:self.yinxiang.view];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.yinxiang.view.frame = nextVCRect;
        self.yinxiang.view.alpha = 1;
        
        
    }];
    
}
- (void)closeCurrentvc{
    [UIView animateWithDuration:0.5f animations:^{
        
        
        self.yinxiang.view.frame = CGRectMake(0, 0, 40, 40);//self.originRect;
        self.yinxiang.view.center = self.view.center;
        self.yinxiang.view.layer.cornerRadius = 20.0f;
//        self.yinxiang.view.alpha = 0;
    } completion:^(BOOL finished) {
//        [self.yinxiang.view removeFromSuperview];
//        [self.yinxiang removeFromParentViewController];
//        self.yinxiang = nil;
//        self.tableView.scrollEnabled = YES;
    }];
}
- (YiXiangTranVC *)yinxiang{
    if (!_yinxiang) {
        _yinxiang = [[YiXiangTranVC alloc] init];
    }
    return _yinxiang;
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
