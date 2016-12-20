//
//  CompanyProductsController.h
//  JAJ
//
//  Created by Chan_Sir on 2016/12/20.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "SuperViewController.h"
#import "CompayModel.h"


typedef NS_ENUM(NSInteger,DetialInfoType) {
    BasicInfoType = 1, // 企业基本信息
    ContactInfoType = 2, // 联系信息
    ProductInfoType = 3, // 产品列表信息
    //    XinYongInfoType = 4  // 信用信息
};


@interface CompanyProductsController : SuperViewController

@property (strong,nonatomic) CompayModel *model;

@end
