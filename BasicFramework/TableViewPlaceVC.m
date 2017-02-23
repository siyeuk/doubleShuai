//
//  TableViewPlaceVC.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/23.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "TableViewPlaceVC.h"
#import "UITableView+LSTableViewPlaceHolder.h"
#import "XTNetReloader.h"
#import "WeChatStylePlaceHolder.h"
@interface TableViewPlaceVC ()<UITableViewDelegate,UITableViewDataSource,LSTableViewPlaceHolderDelegate,WeChatStylePlaceHolderDelegate>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation TableViewPlaceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];

    // Do any additional setup after loading the view.
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView ls_reloadData];
        });
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
- (UIView *)makePlaceHoderView{
    UIView *taobaoStyle = [self taoBaoStylePlaceHolder];
    UIView *weChatStyle = [self weChatStylePlaceHolder];
    return (arc4random_uniform(2)==0)?taobaoStyle:weChatStyle;
}
- (UIView *)taoBaoStylePlaceHolder {
    __block XTNetReloader *netReloader = [[XTNetReloader alloc] initWithFrame:CGRectMake(0, 0, 0, 0)
                                                                  reloadBlock:^{
                                                                      [self.tableView ls_reloadData];
                                                                  }] ;
    return netReloader;
}
- (BOOL)enableScrollWhenPlaceHolderViewShowing{
    return YES;
}
- (UIView *)weChatStylePlaceHolder {
    WeChatStylePlaceHolder *weChatStylePlaceHolder = [[WeChatStylePlaceHolder alloc] initWithFrame:self.tableView.frame];
    weChatStylePlaceHolder.delegate = self;
    return weChatStylePlaceHolder;
}
- (void)emptyOverlayClicked:(id)sender{
    [self.tableView ls_reloadData];
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
