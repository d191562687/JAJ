//
//  WebViewTableCell.m
//  JAJ
//
//  Created by Chan_Sir on 2016/12/15.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "WebViewTableCell.h"


@interface WebViewTableCell ()<UIWebViewDelegate>

@property (strong,nonatomic) UIWebView *webView;

@end

static CGFloat staticheight = 0;

@implementation WebViewTableCell

+ (CGFloat)cellHeight
{
    return staticheight;
}

+ (instancetype)sharedWebViewTableCell:(UITableView *)tableView
{
    static NSString *ID = @"WebViewTableCell";
    WebViewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WebViewTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.webView];
    }
    return self;
}

- (void)setHtmlString:(NSString *)htmlString
{
    _htmlString = htmlString;
    self.webView.delegate = self;
    [self.webView loadHTMLString:htmlString baseURL:nil];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue] + 20;
    self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    self.webView.hidden = NO;
    if (staticheight != height+1) {
        
        staticheight = height+1;
        
    }
}


- (UIWebView *)webView
{
    if (!_webView) {
        _webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        _webView.userInteractionEnabled = NO;
        _webView.hidden = YES;
    }
    return _webView;
}


@end
