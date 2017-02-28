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
        // 请求格式
        // AFHTTPRequestSerializer            二进制格式
        // AFJSONRequestSerializer            JSON
        // AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];// 上传普通格式
        ///设置请求头
//        [self.manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
        ///设置接收的Content-Type
        self.manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
//        NSSet *postCurrentAcceptSet = self.manager.responseSerializer.acceptableContentTypes;
//        NSMutableSet *postSet = [NSMutableSet setWithSet:postCurrentAcceptSet];
//        [postSet addObject:@"application/json"];
//        [postSet addObject:@"text/html"];
//        [postSet addObject:@"text/plain"];
//        self.manager.responseSerializer.acceptableContentTypes = postSet;
        
        ///设置返回格式为JSON
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        ///请求的最大任务数
        self.manager.operationQueue.maxConcurrentOperationCount = 5;

        self.manager.requestSerializer.timeoutInterval = 8.0f;
    }
    return self;
}
////POST
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

////GET
- (void)GET:(NSString *)url inPut:(NSDictionary *)dic success:(SuccessBlockType)successBlock failer:(FailedBlockType)failedBlock{
    [self.manager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
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


////上传文件
- (void)uploadRequest{
    ///上传资源地址
    NSString *url = @"";
    ///参数
    NSDictionary *parameters = @{@"":@"",@"":@""};
    [self.manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a = [date timeIntervalSince1970];
        NSString *fileName = [NSString stringWithFormat:@"file_%0.f.txt",a];
        
//        [FileUtils writeDataToFile:fileName data:[@"upload_file_to_server" dataUsingEncoding:NSUTF8StringEncoding]];
//        // 获取数据转换成data
//        NSString *filePath =[FileUtils getFilePath:fileName];
//        // 拼接数据到请求题中
//        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"headUrl" fileName:fileName mimeType:@"application/octet-stream" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



















@end
