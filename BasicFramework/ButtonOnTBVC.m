//
//  ButtonOnTBVC.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/21.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "ButtonOnTBVC.h"

@interface ButtonOnTBVC ()

@property (nonatomic,strong) UIButton *button;

@end

@implementation ButtonOnTBVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.button];
    }
    return self;
}
- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.frame = CGRectMake(10, 10, self.bounds.size.width-20, self.bounds.size.height-20);
        _button.backgroundColor = [UIColor orangeColor];
        [_button setTitle:@"button" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonBeClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}
- (void)buttonBeClicked:(UIButton *)sender{
    SEL selector = NSSelectorFromString(@"tableViewCellButtonBeClicked:atIndex:");
    [self sendActionToControllerWithSelectior:selector];
}
- (void)sendActionToControllerWithSelectior:(SEL)selector{
    NSIndexPath *indexPath = [self.superVC.tableView indexPathForCell:self];
    ///self.superVC 需要从定制cell的时候传过来，为防止循环引用，应该使用（weak，nonatomic）
    if ([self.superVC respondsToSelector:selector]) {
        //performSelector函数是一个技巧:withObject没有“可能导致泄漏,因为它的选择器是未知”的警告
        // func is a trick for performSelector:withObject without "may cause a leak because its selector is unknown" warning
        // [self.controller performSelector:selector
        //                       withObject:self.collectionView
        //                       withObject:indexPath];
        IMP imp = [self.superVC methodForSelector:selector];
        void(*func)(id,SEL,UIViewController *,NSIndexPath *) = (void *)imp;
        func(self.superVC,selector,self.superVC,indexPath);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
