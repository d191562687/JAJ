//
//  ChangePassWordViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/12/8.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "ChangePassWordViewController.h"

@interface ChangePassWordViewController ()

@end

@implementation ChangePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
}

- (void)getData
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appShiyts_URL];
//    请求参数：json={USERNAME :"san",PASSWORD:"1",NEWPAS1:"2",NEWPAS2:"2"}
//    用户名		密码		新密码		确认密码
    NSDictionary *params = @{
                             @"USERNAME":@"20",
                             @"PASSWORD":@"20",
                             @"NEWPAS1":@"20",
                             @"NEWPAS2":@"20"
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {

        
        //     NSLog(@"responseObject = %@",responseObject);
        NSString *code = [[responseObject objectForKey:@"code"] description];
        NSString *desc = [[responseObject objectForKey:@"desc"] description];
        if ([code isEqualToString:@"0000"]) {
            // 成功
            
//            NSArray *data = [responseObject objectForKey:@"data"];
//            self.hangyeArray = [HomeListModel mj_objectArrayWithKeyValuesArray:data];
//            
//            [self.tableView reloadData];

            
        }else{
            // 不成功
            [self sendAlertAction:desc];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self sendAlertAction:error.localizedDescription];
    }];
    
    
    
    
}


@end
