//
//  UITableView+LSTableViewPlaceHolder.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/23.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "UITableView+LSTableViewPlaceHolder.h"
#import <objc/runtime.h>
@interface UITableView()

@property (nonatomic,assign) BOOL scrollIsEnables;
@property (nonatomic,strong) UIView *placeHolderView;

@end


@implementation UITableView (LSTableViewPlaceHolder)


- (BOOL)scrollIsEnables{
    NSNumber *scrollIsEnableObject = objc_getAssociatedObject(self, @selector(scrollIsEnables));
    return [scrollIsEnableObject boolValue];
}
- (void)setScrollIsEnables:(BOOL)scrollIsEnables{
    NSNumber *scrollIsEnableObjects = [NSNumber numberWithBool:scrollIsEnables];
    objc_setAssociatedObject(self, @selector(scrollIsEnables), scrollIsEnableObjects, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)placeHolderView{
    return objc_getAssociatedObject(self, @selector(placeHolderView));
}
- (void)setPlaceHolderView:(UIView *)placeHolderView{
    objc_setAssociatedObject(self, @selector(placeHolderView), placeHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)ls_reloadData{
    [self reloadData];
    [self ls_checkEmpty];
}
- (void)ls_checkEmpty{
    BOOL isEmpty = YES;
    
    id<UITableViewDataSource> src = self.dataSource;
    NSInteger sections = 1;
    if ([src respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [src numberOfSectionsInTableView:self];
    }
    for (int i = 0; i<sections; i++) {
        NSInteger rows = [src tableView:self numberOfRowsInSection:i];
        if (rows) {
            isEmpty = NO;
            break;
        }
    }
    
    ///不同时为空
    //1 1 有 无
    //1 0 有 有
    //0 1 空 无
    //0 0 空 有
    if (!isEmpty != !self.placeHolderView) {
        if (isEmpty) {
            BOOL scrollEnabled = NO;
            if ([self respondsToSelector:@selector(enableScrollWhenPlaceHolderViewShowing)]) {
                scrollEnabled = [self performSelector:@selector(enableScrollWhenPlaceHolderViewShowing)];
                if (!scrollEnabled) {
                    NSString *reason = @" `-enableScrollWhenPlaceHolderViewShowing`的返回值不是必须的，默认为NO ";
                    @throw [NSException exceptionWithName:NSGenericException
                                                   reason:reason
                                                 userInfo:nil];
                }
            } else if ([self.delegate respondsToSelector:@selector(enableScrollWhenPlaceHolderViewShowing)]) {
                scrollEnabled = [self.delegate performSelector:@selector(enableScrollWhenPlaceHolderViewShowing)];
                if (!scrollEnabled) {
                    NSString *reason = @" `-enableScrollWhenPlaceHolderViewShowing`的返回值不是必须的，默认为NO";
                    @throw [NSException exceptionWithName:NSGenericException
                                                   reason:reason
                                                 userInfo:nil];
                }
            }
            
            NSLog(@"%u",scrollEnabled);
            self.scrollEnabled = scrollEnabled;
            
            
            if ([self respondsToSelector:@selector(makePlaceHoderView)]) {
                self.placeHolderView = [self performSelector:@selector(makePlaceHoderView)];
            } else if ( [self.delegate respondsToSelector:@selector(makePlaceHoderView)]) {
                self.placeHolderView = [self.delegate performSelector:@selector(makePlaceHoderView)];
            } else {
                NSString *selectorName = NSStringFromSelector(_cmd);
                NSString *reason = [NSString stringWithFormat:@"必须实现得到占位图的方法： %@", selectorName];
                @throw [NSException exceptionWithName:NSGenericException
                                               reason:reason
                                             userInfo:nil];
            }
            self.placeHolderView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
            [self addSubview:self.placeHolderView];

        }else{
            [self.placeHolderView removeFromSuperview];
            self.placeHolderView = nil;
        }
    }else if(isEmpty){
        ///放到最上面
        [self.placeHolderView removeFromSuperview];
        [self addSubview:self.placeHolderView];
    }
    
    
}


@end
