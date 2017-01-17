//
//  DB.h
//  E钢材
//
//  Created by MS on 16/11/7.
//  Copyright © 2016年 lishuangshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlockType)(id respondData);
typedef void(^FailedBlockType)(NSError *error);

@interface DB : NSObject

+ (instancetype)SI;

- (void)POST:(NSString *)url inPut:(NSDictionary *)dic success:(SuccessBlockType)successBlock failer:(FailedBlockType)failedBlock;

@end
