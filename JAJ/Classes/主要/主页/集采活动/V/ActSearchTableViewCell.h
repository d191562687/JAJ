//
//  ActSearchTableViewCell.h
//  JAJ
//
//  Created by 金安健 on 2016/11/29.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActSearchViewModel.h"


@interface ActSearchTableViewCell : UITableViewCell
/** 创建数据模型 */
@property (strong,nonatomic) ActSearchViewModel * actSearchModel;

/**类初始化方法*/
+ (instancetype)actcellWithactSearchModel:(UITableView *)tableView;


@end
