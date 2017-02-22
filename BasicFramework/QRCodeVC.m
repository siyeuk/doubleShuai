//
//  QRCodeVC.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/22.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "QRCodeVC.h"
#import "CIImage+SGExtension.h"
#import "ScanCodeVC.h"
@interface QRCodeVC ()
@property (weak, nonatomic) IBOutlet IQTextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *normalImageView;
@property (weak, nonatomic) IBOutlet UIImageView *smallPicImageView;
@property (weak, nonatomic) IBOutlet UIImageView *colorImage;

@end

@implementation QRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
////生成二维码
- (IBAction)generateCode:(UIButton *)sender {
    [self.view endEditing:YES];
    ///生成二维码（default）
    [self setupGenerateQRCode];
    ////生成带有图标的二维码
    [self setupIconQRCode];
    ///生成彩色二维码
    [self setupColorQRCode];
}
///default二维码
- (void)setupGenerateQRCode{
    ///创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    ///回复滤镜默认属性
    [filter setDefaults];
    
    ///设置数据
    NSAssert(self.textView.text.length>0, @"请输入需要生成二维码的文字");
    NSString *info = self.textView.text;
    //转换字符串
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    ////通过KVC设置路径inputMessage数据
    [filter setValue:infoData forKey:@"inputMessage"];
    ////获取滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    ///借助UIImageView显示二维码
    ///将CIImage转换成UIImage，
    self.normalImageView.image = [outputImage SG_createNonInterpolatedWithSize:self.normalImageView.bounds.size.width];
    
}
///带有小图标
- (void)setupIconQRCode{
    ///创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    ///回复滤镜默认属性
    [filter setDefaults];
    
    ///设置数据
    NSAssert(self.textView.text.length>0, @"请输入需要生成二维码的文字");
    NSString *info = self.textView.text;
    //转换字符串
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    ////通过KVC设置路径inputMessage数据
    [filter setValue:infoData forKey:@"inputMessage"];
    ////获取滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
   
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    
    ///转为image
    UIImage *startImage = [UIImage imageWithCIImage:outputImage];
     //---------------添加小图标---------------//
    ////开启绘图，获取图形上下文(上下文的大小, 就是二维码的大小)
    UIGraphicsBeginImageContext(startImage.size);
    
    ///把图片画上去
    [startImage drawInRect:CGRectMake(0, 0, startImage.size.width, startImage.size.height)];
    ///把小图标画上去
    UIImage *iconImage = [self drawTabBarItemBackgroundImageWithSize:CGSizeMake(100, 100)];
    [iconImage drawInRect:CGRectMake(startImage.size.width/2-50, startImage.size.height/2-50, 100, 100)];
    
    ///获取当前画的这张图片
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    
    ///关闭图形上下文
    UIGraphicsEndImageContext();
    
    ///显示图片
    self.smallPicImageView.image = finalImage;
    
}
///生成彩色二维码
- (void)setupColorQRCode{
    ///创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    ///回复滤镜默认属性
    [filter setDefaults];
    
    ///设置数据
    NSAssert(self.textView.text.length>0, @"请输入需要生成二维码的文字");
    NSString *info = self.textView.text;
    //转换字符串
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    ////通过KVC设置路径inputMessage数据
    [filter setValue:infoData forKey:@"inputMessage"];
    ////获取滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    ///方法图片
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(9, 9)];
    
    ///创建猜测过滤器
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    
    //设置默认值
    [colorFilter setDefaults];
    
    // 5、KVC 给私有属性赋值
    [colorFilter setValue:outputImage forKey:@"inputImage"];
    
    // 6、需要使用 CIColor
    [colorFilter setValue:[CIColor colorWithRed:1 green:0 blue:0.8] forKey:@"inputColor0"];
    [colorFilter setValue:[CIColor colorWithRed:0.3 green:0.2 blue:0.4] forKey:@"inputColor1"];
    
    // 7、设置输出
    CIImage *colorImage = [colorFilter outputImage];
    
    ///显示图片
    self.colorImage.image = [UIImage imageWithCIImage:colorImage];

}
////扫描二维码
- (IBAction)scanCode:(UIButton *)sender {
    [self.view endEditing:YES];
    [self.navigationController pushViewController:[[ScanCodeVC alloc] init] animated:YES];
}

////生成图片
- (UIImage *)drawTabBarItemBackgroundImageWithSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 43/255.0, 134/255.0, 136/255.0, 1);
    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
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
