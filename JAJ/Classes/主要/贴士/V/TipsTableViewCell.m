//
//  TipsTableViewCell.m
//  JAJ
//
//  Created by 金安健 on 2016/12/7.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "TipsTableViewCell.h"
#import <Masonry.h>

@interface TipsTableViewCell ()

@property (strong,nonatomic) UILabel *contentLabel;

@property (strong,nonatomic) UILabel *pathLabel;

@property (strong,nonatomic) UILabel *titleLabel;

@end
@implementation TipsTableViewCell

+ (instancetype)shareTipsTableViewCell:(UITableView *)tableView
{
    /** 设置cell标签 */
    static NSString *ID = @"TipsTableViewCell";
    TipsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TipsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


- (void)setModel:(TipsModel *)model
{
    _model = model;
    
    _contentLabel.text = model.content;
    _pathLabel.text = model.path;
    _titleLabel.text = model.title;;

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
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 50)];
    self.titleLabel.textColor = RGBACOLOR(24, 24, 24, 1);
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.titleLabel];
    
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    self.contentLabel.textColor = RGBACOLOR(24, 24, 24, 1);
    self.contentLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.contentLabel];
    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(50);
//        make.left.equalTo(self.mas_left).offset(18);
//        make.height.equalTo(@42);
//        make.right.equalTo(self.mas_right).offset(-15);
//    }];
//    
//    self.timeLabel = [[UILabel alloc]init];
//    self.timeLabel.textColor = [UIColor lightGrayColor];
//    self.timeLabel.font = [UIFont systemFontOfSize:12];
//    [self addSubview:self.timeLabel];
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.mas_right).offset(-16);
//        make.height.equalTo(@21);
//        make.top.equalTo(self.titleLabel.mas_bottom);
//    }]; 
    
}


@end
