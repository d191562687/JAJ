//
//  CompayModel.h
//  JAJ
//
//  Created by 金安健 on 2016/12/6.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface CompayModel : NSObject
/** 企业ID */
@property (strong,nonatomic) NSString * ID;
/** 企业类型 -- 1是生产企业 2是经营企业 */
@property (copy,nonatomic) NSString *QY;
/** 企业名称  */
@property (strong,nonatomic) NSString * QYMC;
/** 企业编号 */
@property (strong,nonatomic) NSString * ROW_ID;

@end
