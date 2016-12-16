//
//  FoodTableViewCell.h
//  JAJ
//
//  Created by 金安健 on 2016/12/8.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"

@interface FoodTableViewCell : UITableViewCell
/** 创建数据模型 */
@property (strong,nonatomic) FoodModel * foodModel;
/** 类初始化方法 */
+ (instancetype)foodCellWithFoodModel:(UITableView *)tableView;

@end
