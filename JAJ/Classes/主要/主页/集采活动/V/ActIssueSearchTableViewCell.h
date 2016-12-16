//
//  ActIssueSearchTableViewCell.h
//  JAJ
//
//  Created by 金安健 on 2016/12/1.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActIssueSearchModel.h"
@interface ActIssueSearchTableViewCell : UITableViewCell
/** 创建模型 */
@property (strong,nonatomic) ActIssueSearchModel * issuemodel;
/** 类初始化方法 */
+ (instancetype)actIssueCellWithIssueModel:(UITableView *)tableView;
@end
