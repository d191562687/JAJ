//
//  ActSearchViewModel.h
//  JAJ
//
//  Created by 金安健 on 2016/11/29.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//totalPage = 2,
//data = [
//{
//    CJZZSJ = 2016-09-30,
//    CJZT = 0,
//    CJJG = 122,
//    FQR = 1,
//    JZCGFB_ID = f51ab960f0a9420083a2c1cc873611d8,
//    XGSL = 12111,
//    YCJSL = 1,
//    CJSL = 1111,
//    GUIG = 12只装,
//    DJBH = B00000041,
//    PINM = 优妮斯天然胶乳橡胶避孕套（冰爽型）,
//    ROW_ID = 1,
//    DANW = 盒,
//    FQSJ = 2016-09-21 15:27:41,
//    SCCJ = 优丽达斯(张家港)乳胶制业有限公司,
//    SCJ = 223,
//    ZSJBM = Q00000111
//},
//{
//    JZCGFB_ID = ccb97e288e2841e58903972146edd90d,
//    ROW_ID = 3,
//    CJZT = 0,
//    CJZZSJ = 2016-09-30,
//    SCJ = 12,
//    ZZJG_NAME = 物美超市(马家堡店),
//    YCJSL = 2,
//    ZZJG_ID = 358c17e4b30a4b599c778d122522db87,
//    FQR = 7574ebb75e7e4891bf61cc41fb6c24c4,
//    ZSJBM = S000011624,
//    DJBH = B00000039,
//    FQJG = 358c17e4b30a4b599c778d122522db87,
//    GUIG = *1,
//    CPZS = <p>多大的</p>,
//    CJJG = 9,
//    PINM = 桔红糕,
//    XGSL = 100,
//    CJSL = 1000,
//    FQSJ = 2016-09-21 15:22:38,
//    SCCJ = 波力,
//    DANW = 盒
//    },


#import <Foundation/Foundation.h>

@interface ActSearchViewModel : NSObject
/** 活动发起时间 */
@property (strong,nonatomic) NSString *FQSJ;
/** 活动终止时间 */
@property (strong,nonatomic) NSString *CJZZSJ;
/** 集采现价 */
@property (assign,nonatomic) NSString *CJJG;
/** 市场价 */
@property (assign,nonatomic) NSString *SCJ;
/** 限购数量*/
@property (assign,nonatomic) NSString *XGSL;
/** 集采数量*/
@property (assign,nonatomic) NSString *CJSL;
/** 品名 */
@property (strong,nonatomic) NSString *PINM;
/** 生产厂家 */
@property (strong,nonatomic) NSString *SCCJ;
/** 已集采数 */
@property (assign,nonatomic) NSString *YCJSL;
/** 单据编号 */
@property (strong,nonatomic) NSString *DJBH;
/** 规格 */
@property (strong,nonatomic) NSString *GUIG;
/** 单位 */
@property (strong,nonatomic) NSString *DANW;
/** 发起人 */
@property (strong,nonatomic) NSString *FQR;
/** 发布ID */
@property (strong,nonatomic) NSString *JZCGFB_ID;
/** 活动机构 */
@property (strong,nonatomic) NSString *ZZJG_NAME;


@end
