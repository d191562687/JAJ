//
//  CloudTableViewCell.h
//  JAJ
//
//  Created by 金安健 on 2016/11/28.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloudTableViewCell : UITableViewCell

@property (strong,nonatomic) UIImageView *imageV;
@property (strong,nonatomic) UILabel *label;
+ (instancetype)sharedCloudTableViewCell:(UITableView *)tableView;

@end


