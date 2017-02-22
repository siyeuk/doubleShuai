//
//  ViewController.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/1/17.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.dataArr[indexPath.row][0];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [[NSClassFromString(self.dataArr[indexPath.row][1]) alloc] init];
    vc.title = self.dataArr[indexPath.row][0];
    [self.navigationController pushViewController:vc animated:YES];
}
- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[@[@"系统相册功能",@"CameraAlbumVC"],@[@"简单转场动画",@"TranAnimationVC"],@[@"图片浏览",@"ScrollPictureVC"],@[@"cell上按钮点击事件",@"ButtonOnCell"],@[@"二维码扫描与生成",@"QRCodeVC"]];
    }
    return _dataArr;
}

/**
 - (void)didSelectItem:(UIImage*)cellImage andTitle:(NSString*)title withRectInCollection:(CGRect)itemRect {
 UIImageView *animateImage = [[UIImageView alloc] initWithFrame:itemRect];
 animateImage.image = cellImage;
 [self.view addSubview:animateImage];
 
 __block CGPoint imgPoint;
 self.calview.positionInViewBlock = ^(CGPoint point){
 imgPoint = point;
 };
 
 //给计算器界面传值
 self.calview.imageViewSize = itemRect.size;
 self.calview.image = cellImage;
 self.calview.typeName = title;
 
 //设置贝塞尔曲线路径动画
 UIBezierPath *path = [UIBezierPath bezierPath];
 [path moveToPoint:animateImage.center];
 [path addCurveToPoint:imgPoint controlPoint1:CGPointMake(animateImage.frame.origin.x, animateImage.frame.origin.y-100 ) controlPoint2:CGPointMake(animateImage.frame.origin.x, animateImage.frame.origin.y-100 )];
 CAKeyframeAnimation *anmiation0 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
 anmiation0.path = path.CGPath;
 anmiation0.duration = 1;
 anmiation0.removedOnCompletion = NO;
 anmiation0.fillMode = kCAFillModeForwards;
 [animateImage.layer addAnimation:anmiation0 forKey:nil];
 [NSTimer scheduledTimerWithTimeInterval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
 [animateImage removeFromSuperview];
 }];
 
 }
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
