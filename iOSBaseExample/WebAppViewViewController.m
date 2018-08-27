
/*
 **iOS8**之后，苹果推出了`WKWebView`来代替`UIWebView`组件。如要使用`WKWebView`,需要引入`#import <WeKit/WebKit.h>`.
 */

#import "WebAppViewViewController.h"
#import <WebKit/WebKit.h>

@interface WebAppViewViewController() <WKNavigationDelegate, WKUIDelegate>

@property(nonatomic, strong) WKWebView *myWebView;

@end

@implementation WebAppViewViewController

@synthesize myWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    myWebView = [[WKWebView alloc] initWithFrame:self.view.frame];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    
    NSLog(@"url: %@", urlRequest.URL.absoluteString);
    
    //加载网页，与UIWebView一致
    [myWebView loadRequest:urlRequest];
    
    myWebView.UIDelegate = self;
    myWebView.navigationDelegate = self;
    
    [self.view addSubview:myWebView];
}

//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}
//内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
//页面加载完成之后调用
- (void) webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}
//页面加载失败时调用
- (void) webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailProvisionalNavigation withError: %ld, %@", (long)[error code], [error localizedDescription]);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailNavigation withError: %ld, %@", (long)[error code], [error localizedDescription]);
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    //将没有验证的证书设为可信
    NSURLCredential *credential = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
    completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
}
//在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURL *url = navigationAction.request.URL;
    if ([[url host] isEqualToString:@"localhost"]) {
        //不允许跳转
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        //允许跳转
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
//在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    if ([navigationResponse.response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
        NSURL *url = navigationResponse.response.URL;
        if (response.statusCode == 302 && [[url host] isEqualToString:@"localhost"]) {
            //不允许跳转
            decisionHandler(WKNavigationResponsePolicyCancel);
        }
    }
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
}
//接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
}

@end
