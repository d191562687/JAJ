//
//  FeedBackViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/12/8.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "FeedBackViewController.h"
#import "CWStarRateView.h"

@interface FeedBackViewController ()<UITextViewDelegate>

@property (strong, nonatomic) CWStarRateView *starRateView1;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, weak) UILabel *placeHolder;


@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    
    [self initSubView];
}

//初始化
- (void)initSubView
{
    /** 星星 */
    self.starRateView1 = [[CWStarRateView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 16, SCREEN_HEIGHT / 15, SCREEN_WIDTH / 1.2, SCREEN_HEIGHT / 12) numberOfStars:10];
    self.starRateView1.scorePercent = 1.0;
    self.starRateView1.allowIncompleteStar = NO;
    self.starRateView1.hasAnimation = YES;
    [self.view addSubview:self.starRateView1];

    /** textview */
    _textView.delegate = self;
    [self setupPlaceHolder];
    
}

// 给textView添加一个UILabel子控件
- (void)setupPlaceHolder
{
    UILabel *placeHolder = [[UILabel alloc] initWithFrame:CGRectMake(15, -2, SCREEN_WIDTH - 2 * 15, 200)];
    self.placeHolder = placeHolder;
    
    placeHolder.text = @"请详细描述您的意见和建议...";
    placeHolder.textColor = [UIColor lightGrayColor];
    placeHolder.numberOfLines = 0;
    placeHolder.contentMode = UIViewContentModeTop;
    [_textView addSubview:placeHolder];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    if (!_textView.text.length) {
        self.placeHolder.alpha = 1;
    } else {
        self.placeHolder.alpha = 0;
    }
}

@end
