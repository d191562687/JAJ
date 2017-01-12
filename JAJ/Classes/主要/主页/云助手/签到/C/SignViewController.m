//
//  SignViewController.m
//  JAJ
//
//  Created by 杜彪 on 2016/12/4.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "SignViewController.h"
#import "Calendar.h"
#import "UserInfoManager.h"

@interface SignViewController ()
/** 签到天数 */
@property (strong, nonatomic) IBOutlet UILabel *day;
/** 云豆值 */
@property (strong, nonatomic) IBOutlet UILabel *number;
/** 当前日期 */
@property (strong,nonatomic) NSString * dateString;
/** 日期 */
@property (strong,nonatomic) NSMutableArray * arrData;
/** 签到日历 */
@property (strong,nonatomic) Calendar * calendar;
@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
     self.title = @"签到";

    [self setupView];
    
    [self getDataOne];
    
}
/** 创建签到页面 */
- (void)setupView
{
    self.calendar = [[Calendar alloc] initWithFrame:CGRectMake(20,20, SCREEN_WIDTH - 40 , SCREEN_HEIGHT / 1.7)];
    [self.view addSubview:self.calendar];
    
    //获取当前时间，日期
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    self.dateString = [dateFormatter stringFromDate:currentDate];
    
    //读取存入的数组 打印
    NSArray * arrNew = [[NSUserDefaults standardUserDefaults] objectForKey:@"mutableArr"];
    [self.calendar initSign:arrNew Touch:^(NSString *date) {
    
        NSLog(@"点击了日期:%@",date);
    }];
    
}

- (void)setupCal
{
    //读取存入的数组 打印
    NSArray * arrNew = [[NSUserDefaults standardUserDefaults] objectForKey:@"mutableArr"];
    //显示
    [self.calendar initSign:arrNew Touch:^(NSString *date) {
        NSLog(@"点击了日期:%@",date);
    }];

}
/** 签到 */
- (IBAction)calendarUP:(id)sender {
    
    [self getData];
    
}

- (void)getDataOne
{
    UserModel * model = [UserInfoManager getUserInfo];
    
    self.arrData = [[NSMutableArray alloc]init];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appQiandCX_URL];
    
    NSDictionary *params = @{
                             @"USERNAME":model.USERNAME
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        //   NSLog(@"responseObject = %@",responseObject);
        //    NSString *code = [[responseObject objectForKey:@"code"] description];
        NSString *desc = [[responseObject objectForKey:@"desc"] description];
        if ([desc isEqualToString:@"查询签到"]) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            NSArray * arr = [data objectForKey:@"list"];
            for (id object in arr) {
                NSString * ss = [object objectForKey:@"QIAND_RIQ"];
                NSString * bb = [ss substringFromIndex:ss.length - 2];
                [self.arrData addObject:bb];
            }
            NSArray * arrNew = [NSArray array];
            arrNew = self.arrData;
            //存入数组并同步
            [[NSUserDefaults standardUserDefaults] setObject:arrNew forKey:@"mutableArr"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self setupCal];
            
            /** 云豆／天数 */
            NSString * yund = [data objectForKey:@"countyund"];
            NSString * zong = [data objectForKey:@"countzong"];
            self.day.text = [NSString stringWithFormat:@"%@",zong];
            self.number.text = [NSString stringWithFormat:@"%@",yund];
            
        }else{
            // 不成功
            [self sendAlertAction:desc];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self sendAlertAction:error.localizedDescription];
    }];

}

- (void)getData
{
    UserModel * model = [UserInfoManager getUserInfo];
    
    self.arrData = [[NSMutableArray alloc]init];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appQiand_URL];
    
    NSDictionary *params = @{
                             @"USERNAME":model.USERNAME,
                             @"RIQ":self.dateString,
                             @"YUND":@"1"
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
    //   NSLog(@"responseObject = %@",responseObject);
    //    NSString *code = [[responseObject objectForKey:@"code"] description];
        NSString *desc = [[responseObject objectForKey:@"desc"] description];
        if ([desc isEqualToString:@"签到成功"]) {
        [self showErrorTips:@"签到成功"];
            
        NSDictionary *data = [responseObject objectForKey:@"data"];
        NSArray * arr = [data objectForKey:@"list"];
        for (id object in arr) {
            NSString * ss = [object objectForKey:@"QIAND_RIQ"];
            NSString * bb = [ss substringFromIndex:ss.length - 2];
            [self.arrData addObject:bb];
        }
        NSArray * arrNew = [NSArray array];
        arrNew = self.arrData;
        //存入数组并同步
        [[NSUserDefaults standardUserDefaults] setObject:arrNew forKey:@"mutableArr"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self setupCal];
            
        /** 云豆／天数 */
        NSString * yund = [data objectForKey:@"countyund"];
        NSString * zong = [data objectForKey:@"countzong"];
        self.day.text = [NSString stringWithFormat:@"%@",zong];
        self.number.text = [NSString stringWithFormat:@"%@",yund];
        
        }else{
            // 不成功
            [self sendAlertAction:desc];
            
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {

        [self sendAlertAction:error.localizedDescription];
    }];
}

@end
