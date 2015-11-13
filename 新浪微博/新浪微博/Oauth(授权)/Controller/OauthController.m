//
//  OauthController.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/12.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "OauthController.h"
#import "AFNetworking.h"
#import "Account.h"
#import "MBProgressHUD.h"
#import "AccountTool.h"
#import "UIWindow+Extension.h"

#define AppKey 3919183763

@interface OauthController ()<UIWebViewDelegate>

@end

@implementation OauthController



- (void)viewDidLoad {
    

    [super viewDidLoad];

    UIWebView *webView=[[UIWebView alloc]init];
    
    webView.delegate=self;
    
    webView.frame=self.view.bounds;
    NSString *string=[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%lld&redirect_uri=https://www.baidu.com",AppKey];
    NSURL *url=[[NSURL alloc]initWithString:string];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
    
    
    [webView loadRequest:request];
    [self.view addSubview:webView];
}


#pragma mark -UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url=request.URL.absoluteString;
    
    NSRange range=[url rangeOfString:@"code="];
    if (range.length!=0) {
        int loc=range.location+range.length;
        NSString *code=[url substringFromIndex:loc];
        [self accessTakeWithCode:code];
       // return NO;
    }
        
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"Loading";
    //hud.mode=MBProgressHUDModeDeterminate;
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error;
{
    NSLog(@"%@",error);
}

#pragma mark -

-(void)accessTakeWithCode:(NSString *)code
{
    NSString *access_token_url1=[NSString stringWithFormat:@"https://api.weibo.com/oauth2/access_token"];
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"client_secret"]=@"8f19aea4016996e923f594ae8148a2ca";
    dict[@"client_id"]=@AppKey;
    dict[@"grant_type"]=@"authorization_code";
    dict[@"redirect_uri"]=@"https://www.baidu.com";
    dict[@"code"]=code;
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    [manager POST:access_token_url1 parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary *responseObject) {


        Account *account=[Account accountWithDictionary:responseObject];
        [AccountTool saveAccount:account];

        [UIWindow choseRootViewController];
        NSLog(@"%@",account.access_token);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"error---%@",error);
    }];
}


/**
 *  //        NSString *access_token_url=[NSString stringWithFormat:@"https://api.weibo.com/oauth2/access_token?client_id=%lld&client_secret=8f19aea4016996e923f594ae8148a2ca&grant_type=authorization_code&code=%@&redirect_uri=https://www.baidu.com",AppKey,code];
 //        NSURL *accrssUrl=[NSURL URLWithString:access_token_url];
 //        NSMutableURLRequest  *request1=[[NSMutableURLRequest alloc]initWithURL:accrssUrl];
 //        request1.HTTPMethod=@"POST";
 
 //        [NSURLConnection sendAsynchronousRequest:request1 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
 //            if (connectionError) {
 //                NSLog(@"connectionError----%@",connectionError);
 //            }else{
 //            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
 //                NSString *access_token=dict[@"access_token"];
 //            }
 //        }];
 
 // ------------------------------------------------------------------------------------------------------------------------
 //       NSURLSession *session=[NSURLSession sharedSession];
 //
 //       NSURLSessionTask *task=[session dataTaskWithRequest:request1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
 //           NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
 //           NSString *access_token=dict[@"access_token"];
 //       }];
 //
 //       [task resume];
 // ------------------------------------------------------------------------------------------------------------------------
 */
@end
