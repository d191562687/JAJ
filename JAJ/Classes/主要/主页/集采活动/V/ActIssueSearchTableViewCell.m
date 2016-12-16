//
//  ActIssueSearchTableViewCell.m
//  JAJ
//
//  Created by 金安健 on 2016/12/1.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "ActIssueSearchTableViewCell.h"

@interface ActIssueSearchTableViewCell ()

/** 商品编号 */
@property (strong,nonatomic) IBOutlet UILabel * SPDA_SPBH;
/** 品名 */
@property (strong,nonatomic) IBOutlet UILabel * SPDA_PINM;
/** 规格 */
@property (strong,nonatomic) IBOutlet UILabel * SPDA_GUIG;
/** 市场价 */
@property (strong,nonatomic) IBOutlet UILabel * SPDA_PRICE;
/** 单位 */
@property (strong,nonatomic) IBOutlet UILabel * SPDA_ZXBZDW;

@end
@implementation ActIssueSearchTableViewCell

+ (instancetype)actIssueCellWithIssueModel:(UITableView *)tableView
{
    static NSString * identifier = @"ActIssueSearchTableViewCell";
    ActIssueSearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //如何让创建的cell加个戳
        //对于加载的xib文件，可以到xib视图的属性选择器中进行设置
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ActIssueSearchTableViewCell" owner:nil options:nil]firstObject];
        NSLog(@"创建了一个cell");
    }
    return cell;
}

/** 赋值 */
- (void)setIssuemodel:(ActIssueSearchModel *)issuemodel
{
    /** 模型赋值 */
    _issuemodel = issuemodel;
    /** 控件赋值 */
    _SPDA_SPBH.text = issuemodel.SPDA_SPBH;
    _SPDA_GUIG.text = issuemodel.SPDA_GUIG;
    _SPDA_PINM.text = issuemodel.SPDA_PINM;
    _SPDA_ZXBZDW.text = issuemodel.SPDA_ZXBZDW;
    _SPDA_PRICE.text = issuemodel.SPDA_PRICE;
    
}



@end
