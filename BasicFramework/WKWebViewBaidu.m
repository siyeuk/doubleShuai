//
//  WKWebViewBaidu.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/23.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "WKWebViewBaidu.h"
#import <WebKit/WebKit.h>

//#define k_JSBIN_URL @"http://jsbin.com/meniw"

@interface WKWebViewBaidu ()<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic,strong) WKWebView *webView;

@end

@implementation WKWebViewBaidu

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    [self.view addSubview:_webView];
    // Do any additional setup after loading the view.
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"页面开始加载时候调用");
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"当内容开始返回时候调用");
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"页面加载完成后调用");
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"页面加载失败时候调用");
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"接收到服务器跳转请求厚调用");
}
///收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    ///如果相应的地址是百度，则允许跳转
    if ([navigationResponse.response.URL.host.lowercaseString isEqualToString:@"www.baidu.com"]) {
        ///允许跳转
        decisionHandler(WKNavigationResponsePolicyAllow);
        return;
    }
    ///不允许跳转
    decisionHandler(WKNavigationResponsePolicyCancel);
}
///在发送请求前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    ////如果请求的是百度，延迟5s跳转
    if ([navigationAction.request.URL.host.lowercaseString isEqualToString:@"www.baidu.com"]) {
        //        // 延迟5s之后跳转
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //
        //            // 允许跳转
        //            decisionHandler(WKNavigationActionPolicyAllow);
        //        });
        
        // 允许跳转
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    // 不允许跳转
    decisionHandler(WKNavigationActionPolicyCancel);
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
