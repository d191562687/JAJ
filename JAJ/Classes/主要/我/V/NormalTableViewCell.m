//
//  NormalTableViewCell.m
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "NormalTableViewCell.h"
#import <Masonry.h>

@implementation NormalTableViewCell

+ (instancetype)sharedNormalTableViewCell:(UITableView *)tableView
{
    static NSString *ID = @"NormalTableViewCell";
    NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NormalTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        self.backgroundColor = [UIColor whiteColor];
        [self setupsubviews];
    }
    return self;
}
- (void)setupsubviews
{
    self.imageVme = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    [self addSubview:self.imageVme];
    [self.imageVme mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.left.equalTo(self.imageVme.mas_right).offset(10);
    }];;
    
}
@end
