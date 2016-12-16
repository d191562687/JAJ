//
//  HangyeDetialViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "HangyeDetialViewController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <MBProgressHUD.h>


@interface HangyeDetialViewController ()

/** 数据 */
@property (strong,nonatomic) NSString * text;
/** 视图 */
@property (strong,nonatomic) UIWebView * webview;

@end

@implementation HangyeDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"贴士详情";

    /** 加载webView */
    [self setupWebview];
}

#pragma mark - 设置webview

- (void)setupWebview
{
    self.webview = [[UIWebView alloc]initWithFrame:self.view.frame];

    [self.view addSubview:self.webview];
    
    NSString * tipsid = [NSString stringWithFormat:@"%@",self.model.ID];
    NSString * tipstype = [NSString stringWithFormat:@"%d",self.model.TYPE];
    [self getDataWithTipsId:tipsid TipsType:tipstype];
    
}
/** 数据请求 */
- (void)getDataWithTipsId:(NSString *)tipsId TipsType:(NSString *)tipsType
{
    
   NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appTSxq_URL];
   // 请求参数：json={id:"1992",type :"4"}
    NSDictionary *params = @{
                             @"id":tipsId,
                             @"type":tipsType
                             };
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject = %@",responseObject);

        NSArray *data = [responseObject objectForKey:@"data"];
  
        _text = [data valueForKey:@"content"];

        UILabel * tt = [[UILabel alloc]init];
        tt.text = _text;

        /** UD存储贴士详情 */
        NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
        [UD setObject:tt.text forKey:UDTipsDetailed];
      
        NSString * htmlstring = [NSString stringWithFormat:@"%@",tt.text];
        
        NSString *time = [htmlstring stringByReplacingOccurrencesOfString:@"[" withString:@""];
        time = [time stringByReplacingOccurrencesOfString:@"]" withString:@""];
       
        /** 加载到webVIew */
        [self.webview loadHTMLString:time baseURL:nil];

        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self sendAlertAction:error.localizedDescription];
    }];
}


@end
