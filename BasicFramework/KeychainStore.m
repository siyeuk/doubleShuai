//
//  KeychainStore.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/22.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "KeychainStore.h"
#import "SFHFKeychainUtils.h"///该库为MRC

#define SERVICE_NAME @"该钥匙串的识别码"

@implementation KeychainStore

+ (instancetype)saveAndRead{
    static KeychainStore *saveRead = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        saveRead = [[KeychainStore alloc] init];
    });
    return saveRead;
}
- (void)saveCount:(NSString *)conutStr{
    [SFHFKeychainUtils storeUsername:@"count" andPassword:conutStr forServiceName:SERVICE_NAME updateExisting:1 error:nil];
}
- (void)removeCount{
    [SFHFKeychainUtils deleteItemForUsername:@"count" andServiceName:SERVICE_NAME error:nil];
}


@end
