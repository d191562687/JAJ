//
//  TimeModel.m
//  ZJTimeShaft
//
//  Created by jglx on 16/11/10.
//  Copyright © 2016年 Organization. All rights reserved.
//

#import "TimeModel.h"

@implementation TimeModel

-(instancetype)initData:(NSDictionary *)dic{
    if (self=[super init]) {
        self.timeStr=[dic objectForKey:@"timeStr"];
        self.titleStr=[dic objectForKey:@"titleStr"];
        self.detailSrtr=[dic objectForKey:@"detailSrtr"];
    }
    return self;
}

@end
