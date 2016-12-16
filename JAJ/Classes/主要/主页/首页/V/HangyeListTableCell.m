//
//  HangyeListTableCell.m
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "HangyeListTableCell.h"
#import <Masonry.h>


@interface HangyeListTableCell ()

@property (strong,nonatomic) UILabel *titleLabel;

@property (strong,nonatomic) UILabel *timeLabel;

@end

@implementation HangyeListTableCell

+ (instancetype)sharedHangyeListTableCell:(UITableView *)tableView
{
    /** 设置cell标签 */
    static NSString *ID = @"HangyeListTableCell";
    HangyeListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HangyeListTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
- (void)setModel:(HomeListModel *)model
{
    _model = model;
    _titleLabel.text = model.TITLE;
    NSString *time = [model.POST_TIME stringByReplacingOccurrencesOfString:@"(" withString:@""];
    time = [time stringByReplacingOccurrencesOfString:@")" withString:@""];
    _timeLabel.text = time;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setAccessoryType:UITableViewCellAccessoryNone];
        self.backgroundColor = [UIColor whiteColor];
        [self setupsubviews];
    }
    return self;
}
- (void)setupsubviews
{
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = RGBACOLOR(24, 24, 24, 1);
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.left.equalTo(self.mas_left).offset(18);
        make.height.equalTo(@42);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-16);
        make.height.equalTo(@21);
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
    
}


@end
