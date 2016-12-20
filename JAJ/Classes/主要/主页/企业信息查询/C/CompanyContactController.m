//
//  CompanyContactController.m
//  JAJ
//
//  Created by Chan_Sir on 2016/12/20.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "CompanyContactController.h"

@interface CompanyContactController ()

@property (strong,nonatomic) UIWebView *webView;

@end

@implementation CompanyContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业联系信息";
    
    [self.view addSubview:self.webView];
    [self getCompanyInfoWithType:2];
}

/**
 获取公司信息
 
 @param InfoType BasicInfoType = 1,  // 企业基本信息
 ContactInfoType =2, // 联系信息
 */
- (void)getCompanyInfoWithType:(int)InfoType
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appCjXQ_URL];
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    [jsonDict setValue:self.model.QYMC forKey:@"QYMC"];
    [jsonDict setValue:self.model.QY forKey:@"QY"];
    [jsonDict setValue:self.model.ID forKey:@"ID"];
    [jsonDict setValue:[NSString stringWithFormat:@"%d",InfoType] forKey:@"type"];
    
    NSDictionary *params = @{@"json":[self switchToJsonStrFrom:jsonDict]};
    
    [HTTPManager POST:url params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 联系信息
        NSString *data = [[responseObject objectForKey:@"data"] description];
        
        [self.webView loadHTMLString:data baseURL:nil];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self sendAlertAction:error.localizedDescription];
    }];
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 45)];
        _webView.backgroundColor = self.view.backgroundColor;
        _webView.userInteractionEnabled = YES;
    }
    return _webView;
}

@end
