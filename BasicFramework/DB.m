//
//  DB.m
//  E钢材
//
//  Created by MS on 16/11/7.
//  Copyright © 2016年 lishuangshuai. All rights reserved.
//

#import "DB.h"

@interface DB()

@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation DB

+(instancetype)SI{
    static DB *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[DB alloc] init];
    });
    return s_instance;
}
- (instancetype)init{
    if (self = [super init]) {
        self.manager = [[AFHTTPSessionManager alloc] init];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
        NSSet *postCurrentAcceptSet = self.manager.responseSerializer.acceptableContentTypes;
        NSMutableSet *postSet = [NSMutableSet setWithSet:postCurrentAcceptSet];
        [postSet addObject:@"application/json"];
        [postSet addObject:@"text/html"];
        [postSet addObject:@"text/plain"];
        self.manager.responseSerializer.acceptableContentTypes = postSet;
        self.manager.requestSerializer.timeoutInterval = 8.0f;
    }
    return self;
}
- (void)POST:(NSString *)url inPut:(NSDictionary *)dic success:(SuccessBlockType)successBlock failer:(FailedBlockType)failedBlock{
    
    
    
    [self.manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"error_code"]) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"error"]];
        }
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedBlock) {
            failedBlock(error);
        }
        if (error.userInfo[@"NSLocalizedDescription"]) {
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSLocalizedDescription"]];
        }else{
            if (error.debugDescription.length>100) {
                [SVProgressHUD showErrorWithStatus:@"与服务器链接失败，请重新尝试"];
            }else{
                [SVProgressHUD showErrorWithStatus:error.debugDescription];
            }
        }
    }];
}
























@end
