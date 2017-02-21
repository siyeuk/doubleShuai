//
//  CheckVersion.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/21.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "CheckVersion.h"
#import "VersionModel.h"
@implementation CheckVersion

+ (void)checkVersion{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleId = infoDic[@"CFBundleIdentifier"];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@",bundleId]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
           
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (!error) {
                    
                    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                    NSInteger resultCount = [responseDic[@"resultCount"] integerValue];
                    if (resultCount == 1) {
                        
                        NSArray *resultArray = responseDic[@"results"];
                        NSDictionary *result = resultArray.firstObject;
                        VersionModel *appInfo = [[VersionModel alloc] initWithResult:result];
                        ///最新版本
                        NSString *version = appInfo.version;
                        ///当前app版本
                        NSString *currentVersion = infoDic[@"CFBundleShortVersionString"];
                        if ([currentVersion compare:version options:NSNumericSearch] == NSOrderedAscending) {
                            ///更新
                            UIWindow *window = nil;
                            id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
                            if ([delegate respondsToSelector:@selector(window)]) {
                                window = [delegate performSelector:@selector(window)];
                            }else{
                                window = [UIApplication sharedApplication].keyWindow;
                            }
                            
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"发现新版本，是否需要更新？" preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction *action = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                
                            }];
                            [alert addAction:action];
                            [window.rootViewController presentViewController:alert animated:YES completion:^{
                                
                            }];
                            
                        }
                    }
                    
                    
                }else{
                    
                }
            });
        }];
        [dataTask resume];
    });
}

@end
