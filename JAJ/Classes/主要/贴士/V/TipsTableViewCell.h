//
//  TipsTableViewCell.h
//  JAJ
//
//  Created by 金安健 on 2016/12/7.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TipsModel.h"

@interface TipsTableViewCell : UITableViewCell

@property (strong,nonatomic) TipsModel * model;


+ (instancetype)shareTipsTableViewCell:(UITableView *)tableView;

@end
