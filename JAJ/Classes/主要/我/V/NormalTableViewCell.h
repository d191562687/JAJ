//
//  NormalTableViewCell.h
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NormalTableViewCell : UITableViewCell

@property (strong,nonatomic) UIImageView *imageVme;
@property (strong,nonatomic) UILabel *label;
+ (instancetype)sharedNormalTableViewCell:(UITableView *)tableView;

@end
