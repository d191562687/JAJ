//
//  WebViewTableCell.h
//  JAJ
//
//  Created by Chan_Sir on 2016/12/15.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ReloadBlock)();

@interface WebViewTableCell : UITableViewCell

@property(nonatomic,copy)NSString *htmlString;
//@property(nonatomic,copy)ReloadBlock reloadBlock;
+(CGFloat)cellHeight;

+ (instancetype)sharedWebViewTableCell:(UITableView *)tableView;

@end
