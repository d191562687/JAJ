//
//  FoodTableViewCell.m
//  JAJ
//
//  Created by 金安健 on 2016/12/8.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "FoodTableViewCell.h"

@interface FoodTableViewCell ()

/** 商品编号 */
@property (strong,nonatomic) IBOutlet UILabel * SPDA_SPBH;
/** 品名 */
@property (strong,nonatomic) IBOutlet UILabel * SPDA_PINM;
/** 规格 */
@property (strong,nonatomic) IBOutlet UILabel * SPDA_GUIG;
/** 库存数量 */
@property (strong,nonatomic) IBOutlet UILabel * KCSL;
/** 批准文号 */
@property (strong,nonatomic) IBOutlet UILabel * SPDA_SPZSJBM;
/** 组织机构 */
@property (strong,nonatomic) IBOutlet UILabel * JGBS_NAME;
/** 单价 */
@property (strong,nonatomic) IBOutlet UILabel * SPDA_PRICE;
/** 评分 */
@property (strong,nonatomic) IBOutlet UILabel * SPDA_JGBS_DP;
/** 产地 */
@property (strong,nonatomic) IBOutlet UILabel * SPDA_SCG;

@end

@implementation FoodTableViewCell

+ (instancetype)foodCellWithFoodModel:(UITableView *)tableView
{
    static NSString * indentifier = @"FoodTableViewCell";
    FoodTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FoodTableViewCell" owner:nil options:nil]firstObject];
        
    }
    return cell;
}

- (void)setFoodModel:(FoodModel *)FoodModel
{
    //为模型赋值
    _foodModel = FoodModel;
    //为属性赋值
    _SPDA_SPBH.text = FoodModel.SPDA_SPBH;
    _SPDA_PINM.text = FoodModel.SPDA_PINM;
    _SPDA_GUIG.text = FoodModel.SPDA_GUIG;
    _KCSL.text = FoodModel.KCSL;
    _SPDA_SPZSJBM.text = FoodModel.SPDA_SPZSJBM;
    _JGBS_NAME.text = FoodModel.JGBS_NAME;
    _SPDA_PRICE.text = FoodModel.SPDA_PRICE;
    _SPDA_JGBS_DP.text = FoodModel.SPDA_JGBS_DP;
    _SPDA_SCG.text = FoodModel.SPDA_SCG;
    
}

@end
