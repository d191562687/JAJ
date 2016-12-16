//
//  CloudTableViewCell.m
//  JAJ
//
//  Created by 金安健 on 2016/11/28.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "CloudTableViewCell.h"
#import <Masonry.h>

@implementation CloudTableViewCell


+ (instancetype)sharedCloudTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"CloudTableViewCell";
    CloudTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CloudTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return  cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews
{
    self.imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_cloud_know"]];
    [self addSubview:self.imageV];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(15);
        make.width.and.height.equalTo(@26);
    }];
    self.label = [[UILabel alloc]init];
    self.label.font = [UIFont systemFontOfSize:16];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@21);
        make.left.equalTo(self.imageV.mas_right).offset(10);
    }];;
    
   
    
}



@end
