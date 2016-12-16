//
//  FoodModel.h
//  JAJ
//
//  Created by 金安健 on 2016/12/8.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//
//{
//    code = 0000,
//    data = [
//    {
//        SPDA_PZWHYXQ = 2016.08.02,
//        SPDA_ZXBZDW = 瓶,
//        JGBS_NAME = 美廉美超市(角门店),
//        KCSL = 115,
//        INDEXSTATUS = 1,
//        SPDA_PINM = 500ml康师傅水晶葡萄,
//        SPDA_JGBS_DP = 0,
//        SPDA_SCG = 杭州,
//        SPDA_GUIG = 500ml*15,
//        SPDA_SJC = 2016-09-12 18:36:28,
//        ROW_ID = 1,
//        SPDA_PRICE = 2,
//        SPDA_SPBH = sp00000087,
//        SPDA_SPZSJBM = S000011333,
//        SPDA_TXM = 2147483647,
//        SPDA_HDZT = 0,
//        SPDA_ID = 5963f51ed6674c459d385f42b113ca53,
//        SPDA_JGBS = 5dd3843f14824d5c9cae7fbb49faa27f,
//        SPDA_ZJM = KSFSJPT
//    },

            
#import <Foundation/Foundation.h>

@interface FoodModel : NSObject
/** 商品编号 */
@property (strong,nonatomic) NSString * SPDA_SPBH;
/** 品名 */
@property (strong,nonatomic) NSString * SPDA_PINM;
/** 规格 */
@property (strong,nonatomic) NSString * SPDA_GUIG;
/** 库存数量 */
@property (strong,nonatomic) NSString * KCSL;
/** 批准文号 */
@property (strong,nonatomic) NSString * SPDA_SPZSJBM;
/** 组织机构 */
@property (strong,nonatomic) NSString * JGBS_NAME;
/** 单价 */
@property (strong,nonatomic) NSString * SPDA_PRICE;
/** 评分 */
@property (strong,nonatomic) NSString * SPDA_JGBS_DP;
/** 产地 */
@property (strong,nonatomic) NSString * SPDA_SCG;

@end
