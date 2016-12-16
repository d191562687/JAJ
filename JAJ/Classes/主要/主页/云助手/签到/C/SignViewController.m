//
//  SignViewController.m
//  JAJ
//
//  Created by 杜彪 on 2016/12/4.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "SignViewController.h"

@interface SignViewController ()

@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
     self.title = @"签到";


    [self getData];
    

}

- (void)getData
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appQiand_URL];
    
    NSDictionary *params = @{
                             @"USERNAME":@"admin",
                             @"RIQ":@"2016-12-30",
                             @"YUND":@"5"
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
//        [self.tableView.mj_header endRefreshing];
        
        NSLog(@"responseObject = %@",responseObject);

        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
 //       [self.tableView.mj_header endRefreshing];
        [self sendAlertAction:error.localizedDescription];
    }];

    
    
}

@end
