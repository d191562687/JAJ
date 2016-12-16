//
//  FourModel.h
//  JAJ
//
//  Created by 金安健 on 2016/12/5.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//
//id = de07c39407db4f0596e6e7bdcc4054be,
//pzwh = 粤QS440113010488,
//txm = ,
//name = 王老吉润喉糖(铁盒),
//type = 7


#import <Foundation/Foundation.h>

@interface FourModel : NSObject
/** id */
@property (strong,nonatomic) NSString * Id;
/** 批准文号 */
@property (strong,nonatomic) NSString * pzwh;
/** 条形码*/
@property (strong,nonatomic) NSString * txm;
/** 商品名称 */
@property (strong,nonatomic) NSString * name;
/** 商品类别 */
@property (strong,nonatomic) NSString * type;
@end
