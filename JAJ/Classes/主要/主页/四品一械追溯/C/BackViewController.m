//
//  BackViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/12/6.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "BackViewController.h"
#import "BackDetailsViewController.h"
@interface BackViewController ()

{
    int CurrentPage;
}

/** 公司名称 */
@property (weak, nonatomic) IBOutlet UITextField *companyNameField;
/** 产品名称 */
@property (weak, nonatomic) IBOutlet UITextField *productNameField;
/** 生产批次 */
@property (weak, nonatomic) IBOutlet UITextField *piciField;


@end

@implementation BackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"四品一械追溯";
    CurrentPage = 1;
    
}

- (IBAction)SearchAction:(UIButton *)sender
{
    
    if (self.companyNameField.text.length < 1) {
        return;
    }
    if (self.productNameField.text.length < 1) {
        return;
    }
    if (self.piciField.text.length < 1) {
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appSPYXZS_URL];
    
    NSDictionary *params = @{
                             @"type":@"1",
                             @"keyword1":@"华润医药商业集团有限公司",
                             @"keyword2":@"防风通圣颗粒",
                             @"keyword3":@"1406124",
                             @"currentPage":@"0",
                             @"pageSize":@"50"
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"responseObject = %@",responseObject);
//        NSString *desc = [[responseObject objectForKey:@"desc"] description];
//
//        // json数据或者NSDictionary转为NSData，responseObject为json数据或者NSDictionary
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//        // NSData转为NSString
//        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        NSLog(@"-jsonStr--%@---", jsonStr);
        NSArray * arr = [responseObject objectForKey:@"data"];
        for (id object in arr) {
            NSString * ss = [object objectForKey:@"GJ_YANWDH"];
            NSLog(@"--ss---%@",ss);
        }
        //跳转到追溯页
        BackDetailsViewController * backVC = [[BackDetailsViewController alloc]init];
        [self.navigationController pushViewController:backVC animated:YES];
        
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self sendAlertAction:error.localizedDescription];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
}

@end
