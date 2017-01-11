//
//  RightSlidetabletableViewCell.m
//  ZJTimeShaft
//
//  Created by jglx on 16/11/10.
//  Copyright © 2016年 Organization. All rights reserved.
//

#import "RightSlidetabletableViewCell.h"
#import "UIView+SDAutoLayout.h"
@interface RightSlidetabletableViewCell ()

@property (nonatomic,strong)UILabel * verticalLabel1; //竖线
@property (nonatomic,strong)UILabel * verticalLabel2; //竖线
@property (nonatomic,strong)UIButton* circleView;     // 圈
@property (nonatomic,strong)UILabel * titleLabel;     //标题
@property (nonatomic,strong)UILabel * detailLabel;    //描述
@property (nonatomic,strong)UILabel * timeLabel;      //时间
@end

@implementation RightSlidetabletableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)initView{
    self.verticalLabel1 = [[UILabel alloc] init];
    self.verticalLabel1.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.verticalLabel1];
    
    self.verticalLabel2 = [[UILabel alloc] init];
    self.verticalLabel2.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.verticalLabel2];
    
    self.circleView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.circleView.backgroundColor = [UIColor whiteColor];
    self.circleView.layer.borderColor = [UIColor grayColor].CGColor;
    self.circleView.layer.cornerRadius = 8;
    self.circleView.layer.borderWidth = 3;
    [self.contentView addSubview:self.circleView];
    //时间
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textColor = [UIColor cyanColor];
    [self.contentView addSubview:self.titleLabel];
    
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.timeLabel];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.font = [UIFont systemFontOfSize:13];
    self.detailLabel.numberOfLines = 0;
    [self.contentView addSubview:self.detailLabel];
    
    self.verticalLabel1.sd_layout
    .topEqualToView(self.contentView)
    .leftSpaceToView(self.contentView,PADDING_OF_LEFT_STEP_LINE)
    .widthIs(2)
    .heightIs(10);
    self.verticalLabel2.sd_layout
    .topSpaceToView(self.contentView,1)
    .leftSpaceToView(self.contentView,PADDING_OF_LEFT_STEP_LINE)
    .widthIs(2)
    .bottomEqualToView(self.contentView);
    
    self.circleView.sd_layout
    .centerXEqualToView(self.verticalLabel1)
    .centerYIs(10)
    .heightIs(16)
    .widthIs(16);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.verticalLabel1,PADDING_OF_LEFT_RIGHT)
    .topSpaceToView(self.contentView,10)
    .heightIs(15)
    .rightEqualToView(self.contentView);
    
    self.timeLabel.sd_layout
    .topSpaceToView(self.titleLabel,9)
    .leftSpaceToView(self.verticalLabel2,PADDING_OF_LEFT_RIGHT)
    .heightIs(11)
    .rightEqualToView(self.contentView);
    
    self.detailLabel.sd_layout
    .topSpaceToView(self.timeLabel,0)
    .leftSpaceToView(self.verticalLabel2,PADDING_OF_LEFT_RIGHT)
    .widthIs(WIDTH_OF_PROCESS_LABLE)
    .heightIs(30);
 
}

-(void)setModel:(TimeModel *)model{
    _model = model;
    self.titleLabel.text = model.titleStr;
    self.timeLabel.text = [NSString stringWithFormat:@"%@",model.timeStr];
    self.detailLabel.text = model.detailSrtr;
    if (model.detailSrtr.length > 1) {
        //描述lab隐藏
        NSDictionary *fontDic = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGSize size1 = CGSizeMake(WIDTH_OF_PROCESS_LABLE,0);
        CGSize detailStrSize = [model.detailSrtr boundingRectWithSize:size1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading   attributes:fontDic context:nil].size;
        self.detailLabel.sd_layout
        .topSpaceToView(self.timeLabel,5)
        .leftSpaceToView(self.verticalLabel2,PADDING_OF_LEFT_RIGHT)
        .widthIs(WIDTH_OF_PROCESS_LABLE)
        .heightIs(detailStrSize.height + 12);
    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
