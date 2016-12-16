//
//  FoueTableViewCell.m
//  JAJ
//
//  Created by 金安健 on 2016/12/5.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "FoueTableViewCell.h"

@interface FoueTableViewCell ()
@property (strong, nonatomic) IBOutlet UILabel *labelname;
@property (strong, nonatomic) IBOutlet UILabel *labelpzwh;
@property (strong, nonatomic) IBOutlet UILabel *labeltxm;
@property (strong, nonatomic) IBOutlet UILabel * labeltype;


@end
@implementation FoueTableViewCell

+ (instancetype)fourCellWithModel:(UITableView *)tableView
{
    static NSString * indentifier = @"FoueTableViewCell";
    FoueTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        //如何让创建的cell加个戳
        //对于加载的xib文件，可以到xib视图的属性选择器中进行设置
        cell=[[[NSBundle mainBundle]loadNibNamed:@"FoueTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
}

/** 重写set */
- (void)setModel:(FourModel *)model
{
    //为模型赋值
    _model = model;
    //为控件属性赋值
    self.labeltxm.text = model.txm;
    self.labelname.text = model.name;
    self.labelpzwh.text = model.pzwh;
    
/** 属性判断*/
    if ([model.type isEqualToString:@"1"]) {
        self.labeltype.text = @"国产保健食品";
    }else if ([model.type isEqualToString:@"2"])
    {
        self.labeltype.text = @"进口保健食品";
    }else if ([model.type isEqualToString:@"3"])
    {
        self.labeltype.text = @"国产器械";
    }else if ([model.type isEqualToString:@"4"])
    {
        self.labeltype.text = @"进口器械";
    }else if ([model.type isEqualToString:@"5"])
    {
        self.labeltype.text = @"国产药品";
    }else if ([model.type isEqualToString:@"6"])
    {
        self.labeltype.text = @"进口药品";
    }else if ([model.type isEqualToString:@"7"])
    {
        self.labeltype.text = @"食品";
    }else if ([model.type isEqualToString:@"8"])
    {
        self.labeltype.text = @"药品";
    }else if ([model.type isEqualToString:@"9"])
    {
        self.labeltype.text = @"器械";
    }
    
    
    
}
@end
