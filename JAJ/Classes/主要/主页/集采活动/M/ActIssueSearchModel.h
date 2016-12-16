//
//  ActIssueSearchModel.h
//  JAJ
//
//  Created by 金安健 on 2016/12/1.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//
//食品：{
//    "code":"0000",
//    "currentPage":1,
//    "data":	[
//             {
//                 "INDEXSTATUS":1,
//                 "ROW_ID":1,
//                 "SPDA_GUIG":"250ML*16",
//                 "SPDA_HDZT":"0",
//                 "SPDA_ID":"9ac900197a944a1db25499d6f5b3960e",
//                 "SPDA_JGBS":"5dd3843f14824d5c9cae7fbb49faa27f",
//                 "SPDA_PINM":"王老吉凉茶",
//                 "SPDA_PRICE":"2",
//                 "SPDA_PZWHYXQ":"2016.08.02",
//                 "SPDA_SCG":" 广州",
//                 "SPDA_SJC":"2016-09-12 18:36:28",
//                 "SPDA_SPBH":"sp00000001",
//                 "SPDA_SPZSJBM":"S000011247",
//                 "SPDA_TXM":"2147483647",
//                 "SPDA_ZJM":"WLJLC",
//                 "SPDA_ZXBZDW":"盒"}
//             ],
//    "desc":"操作成功",
//    "totalPage":30
//}

#import <Foundation/Foundation.h>

@interface ActIssueSearchModel : NSObject
/** 商品编号 */
@property (strong,nonatomic) NSString * SPDA_SPBH;
/** 品名 */
@property (strong,nonatomic) NSString * SPDA_PINM;
/** 规格 */
@property (strong,nonatomic) NSString * SPDA_GUIG;
/** 市场价 */
@property (strong,nonatomic) NSString * SPDA_PRICE;
/** 单位 */
@property (strong,nonatomic) NSString * SPDA_ZXBZDW;
/** 生产厂家 */
@property (strong,nonatomic) NSString * SPDA_SCG;
/** 主数据编码 */
@property (strong,nonatomic) NSString * SPDA_SPZSJBM;

@end
