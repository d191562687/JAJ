//
//  BackViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/12/6.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "BackViewController.h"

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
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@1 forKey:@"type"];
    [dict setValue:self.companyNameField.text forKey:@"keyword1"];
    [dict setValue:self.productNameField.text forKey:@"keyword2"];
    [dict setValue:self.piciField.text forKey:@"keyword3"];
    [dict setValue:[NSString stringWithFormat:@"%d",CurrentPage] forKey:@"currentPage"];
    [dict setValue:@"10" forKey:@"pageSize"];
    
    
    NSDictionary *param = @{@"json":[self switchToJsonStrFrom:dict]};
    
    [HTTPManager POST:url params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject = %@",responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self sendAlertAction:error.localizedDescription];
    }];

    
}

@end
