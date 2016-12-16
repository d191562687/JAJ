//
//  HangyeListTableCell.h
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeListModel.h"


@interface HangyeListTableCell : UITableViewCell


@property (strong,nonatomic) HomeListModel *model;

+ (instancetype)sharedHangyeListTableCell:(UITableView *)tableView;


@end
