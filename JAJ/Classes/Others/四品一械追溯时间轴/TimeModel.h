//
//  TimeModel.h
//  ZJTimeShaft
//
//  Created by jglx on 16/11/10.
//  Copyright © 2016年 Organization. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeModel : NSObject
@property (strong,nonatomic)NSString * timeStr;
@property (strong,nonatomic)NSString * titleStr;
@property (strong,nonatomic)NSString * detailSrtr;

-(instancetype)initData:(NSDictionary *)dic;

@end
