//
//  FoueTableViewCell.h
//  JAJ
//
//  Created by 金安健 on 2016/12/5.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FourModel.h"

@interface FoueTableViewCell : UITableViewCell

/** 创建数据模型 */
@property (strong,nonatomic) FourModel * model;
/** 类初始化方法 */

+ (instancetype)fourCellWithModel:(UITableView * )tableView;


@end
