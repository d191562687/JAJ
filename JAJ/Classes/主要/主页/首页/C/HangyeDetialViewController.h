//
//  HangyeDetialViewController.h
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "SuperViewController.h"
#import "HomeListModel.h"
#import "TipsModel.h"

@interface HangyeDetialViewController : SuperViewController

/** black 传递过来的model数据 */
@property (strong,nonatomic) HomeListModel *model;

@property (strong,nonatomic) TipsModel *  tipsmodel;

@end
