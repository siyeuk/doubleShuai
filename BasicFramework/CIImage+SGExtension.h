//
//  CIImage+SGExtension.h
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/22.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import <CoreImage/CoreImage.h>

@interface CIImage (SGExtension)

/** 将CIImage转换成UIImage */
- (UIImage *)SG_createNonInterpolatedWithSize:(CGFloat)size;


@end
