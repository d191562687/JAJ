//
//  ActSearchTableViewCell.m
//  JAJ
//
//  Created by 金安健 on 2016/11/29.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "ActSearchTableViewCell.h"


@interface ActSearchTableViewCell ()
/** 活动机构 */
@property (strong, nonatomic) IBOutlet UILabel *labelZZJG_NAME;
/** 品名 */
@property (strong, nonatomic) IBOutlet UILabel *labelPINM;
/** 市场价 */
@property (strong, nonatomic) IBOutlet UILabel *labelSCJ;
/** 集采现价 */
@property (strong, nonatomic) IBOutlet UILabel *labelCJJG;
/** 限购数量*/
@property (strong, nonatomic) IBOutlet UILabel *labelCJSL;
/** 活动终止时间 */
@property (strong, nonatomic) IBOutlet UILabel *labelCJZZSJ;

@end

@implementation ActSearchTableViewCell

+ (instancetype)actcellWithactSearchModel:(UITableView *)tableView
{
    static NSString * identifier = @"ActSearchTableViewCell";
    ActSearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //如何让创建的cell加个戳
        //对于加载的xib文件，可以到xib视图的属性选择器中进行设置
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ActSearchTableViewCell" owner:nil options:nil]firstObject];
        NSLog(@"创建了一个cell");
    }
    return cell;
}


/**
 重写set方法

 @param actSearchModel 赋值操作
 */
- (void)setActSearchModel:(ActSearchViewModel *)actSearchModel
{
    //为模型赋值
    _actSearchModel = actSearchModel;
    //为控件属性赋值
    _labelZZJG_NAME.text = actSearchModel.ZZJG_NAME;
    _labelPINM.text = actSearchModel.PINM;
    _labelSCJ.text = actSearchModel.SCJ;
    _labelCJJG.text = actSearchModel.CJJG;
    _labelCJSL.text = actSearchModel.CJSL;
    _labelCJZZSJ.text = actSearchModel.CJZZSJ;
}


@end
