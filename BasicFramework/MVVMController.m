//
//  MVVMController.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/28.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "MVVMController.h"
#import "MVVMTableViewDelegate.h"
#import "MVVMTableViewDataSource.h"
#import "MVVMTableViewModel.h"

@interface MVVMController ()

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) MVVMTableViewDelegate *tableViewDelegate;
@property (nonatomic,strong) MVVMTableViewDataSource *tableViewDataSource;

@property (nonatomic,strong) MVVMTableViewModel *tableViewModel;



@end

@implementation MVVMController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"MVVM";
    self.dataArr = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64) style:UITableViewStylePlain];
    self.tableViewDelegate = [[MVVMTableViewDelegate alloc] init];
    self.tableViewDataSource = [[MVVMTableViewDataSource alloc] init];
    self.tableView.delegate = self.tableViewDelegate;
    self.tableView.dataSource = self.tableViewDataSource;
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refresh];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMore];
    }];
    
    [self.view addSubview:self.tableView];
    
    self.tableViewModel = [[MVVMTableViewModel alloc] init];
    // Do any additional setup after loading the view.
}
- (void)refresh{
    [self.tableViewModel refreshWithCallback:^(NSMutableArray *array) {
        self.dataArr = array;
        self.tableViewDelegate.array = self.dataArr;
        self.tableViewDataSource.array = self.dataArr;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }];
}
- (void)loadMore{
    [self.tableViewModel loadMoreWithCallBack:^(NSMutableArray *array) {
        [self.dataArr addObjectsFromArray:array];
        self.tableViewDelegate.array = self.dataArr;
        self.tableViewDataSource.array = self.dataArr;
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }];
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
