//
//  NearbyViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "NearbyViewController.h"

@interface NearbyViewController ()

@end

@implementation NearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
    
}

- (void)getData
{
    NSString *url = [NSString stringWithFormat:@"http://192.168.1.235:8180/syaq-manager-web/appCjcx/appCjcx/list"];
    
//    NSDictionary *params = @{
//                             @"type":@"1",
//                             @"currentPage":@"1",
//                             @"pageSize":@"10"
//                             };
    NSDictionary *params = @{
                             @"code":@"",
                             @"currentPage":@"",
                             @"pageSize":@""
                             };
    
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"responseObject = %@",responseObject);
        
        NSString *name = [responseObject className];
        NSLog(@"responseObjectName = %@",name);
        
        
        NSString *code = [[responseObject objectForKey:@"code"] description];       
        NSLog(@"code ==  %@",code);
        NSArray * data = [responseObject objectForKey:@"data"];
        NSLog(@"data ==  %@",data);
        
//        NSString *code = [[responseObject objectForKey:@"code"] description];
//        NSString *desc = [[responseObject objectForKey:@"desc"] description];
//        if ([code isEqualToString:@"0000"]) {
//
//            
//        }else{
//            // 不成功
//            [self sendAlertAction:desc];
//        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {

        [self sendAlertAction:error.localizedDescription];
    }];
}

@end
