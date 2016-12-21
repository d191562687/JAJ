//
//  Calendar.m
//  JAJ
//
//  Created by 金安健 on 2016/12/21.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "Calendar.h"
#import "viewFrame.h"

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface Calendar ()
{
    CGFloat selfWidth;                                      // BQLCalendar width
    CGFloat selfHeight;                                     // BQLCalendar height
    CGFloat daysWidth;                                      // date width
    CGFloat daysHeight;                                     // date height
}

@property (nonatomic, strong) NSArray *signedArray;         // has check-in date (format:01、02、22、31）
@property (nonatomic, strong) NSMutableArray *daysArray;    // the array of hold the button
@property (nonatomic, strong) UIButton *signButton;         // button of sign-in today

@end


@implementation Calendar

#pragma mark  the two ways of create BQLCalendar:
//1.init
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self) {
        
        self.layer.borderWidth = 1.f;
        self.layer.borderColor = RGBAlpha(21, 170, 155, 1.0).CGColor;
        
        selfWidth = frame.size.width;
        selfHeight = frame.size.height;
        daysWidth = selfWidth / 7.f;
        daysHeight = selfHeight / 6.f;
        
        _daysArray = [NSMutableArray arrayWithCapacity:42];
        for (int i = 0; i < 42; i++) {
            UIButton *button = [[UIButton alloc] init];
            button.titleLabel.font = [UIFont systemFontOfSize:14.0];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            [_daysArray addObject:button];
        }
    }
    return self;
}

//2.nib
- (void)awakeFromNib {
    
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = RGBAlpha(21, 170, 155, 1.0).CGColor;
    
    selfWidth = self.frame.size.width;
    selfHeight = self.frame.size.height;
    daysWidth = selfWidth / 7.f;
    daysHeight = selfHeight / 6.f;
    
    _daysArray = [NSMutableArray arrayWithCapacity:42];
    for (int i = 0; i < 42; i++) {
        UIButton *button = [[UIButton alloc] init];
        [_daysArray addObject:button];
    }
}

/**
 *  init sign（draw Date）
 *
 *  @param signArray the array of This month has check-in date（format:01、02、22、31，the array can be empty）
 *  @param block
 */
- (void)initSign:(NSArray *)signArray Touch:(calendarBlock )block {
    
    self.block = block;
    _signedArray = signArray;
    [self createCalendarViewWith:[NSDate date]];
}


// crate CalendarView by date of today
- (void)createCalendarViewWith:(NSDate *)date {
    
    // weekday
    NSArray *weekdayArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    UIView *weekdayBackgroundView = [[UIView alloc] init];
    weekdayBackgroundView.backgroundColor = RGBAlpha(21, 170, 155, 0.8);
    weekdayBackgroundView.frame = CGRectMake(0, 0, selfWidth, daysHeight);
    [self addSubview:weekdayBackgroundView];
    
    for (int i = 0; i < 7; i++) {
        UILabel *week = [[UILabel alloc] init];
        week.text     = weekdayArray[i];
        week.font     = [UIFont systemFontOfSize:14];
        week.frame    = CGRectMake(daysWidth * i, 0, daysWidth, daysHeight);
        week.textAlignment   = NSTextAlignmentCenter;
        week.backgroundColor = [UIColor clearColor];
        week.textColor       = RGB(143, 143, 143);
        [weekdayBackgroundView addSubview:week];
    }
    
    // days (1-31)
    for(int i = 0; i < 35; i ++) {
        
        CGFloat x = (i % 7) * daysWidth;
        CGFloat y = (i / 7) * daysHeight + daysHeight;
        
        // create Container view(button)
        UIButton *view = [[UIButton alloc] initWithFrame:CGRectMake(x, y, daysWidth, daysHeight)];
        [self addSubview:view];
        view.backgroundColor = [UIColor clearColor];
        view.titleLabel.alpha = 0.0;
        
        // put the daybutton in view
        UIButton *dayButton = _daysArray[i];
        dayButton.frame = CGRectMake((daysWidth / 2) - (daysWidth / 2) / 2, (daysHeight / 2) - (daysWidth / 2) / 1.3, daysWidth / 2, daysWidth / 2);
        dayButton.layer.cornerRadius = daysWidth / 4.0;
        dayButton.backgroundColor = [UIColor clearColor];
        [view addSubview:dayButton];
        
        NSInteger daysInLastMonth = [self totaldaysInMonth:[self lastMonth:date]];
        NSInteger daysInThisMonth = [self totaldaysInMonth:date];
        NSInteger firstWeekday    = [self firstWeekdayInThisMonth:date];
        NSInteger day = 0;
        
        // get Chinese calendar
        NSString *nowStr; // 2016-03-10、2016-03-11 ...
        NSString *now = [self getDateForNowWithFormatter:@"YYYY-MM-dd"];
        NSArray *year_month_day = [now componentsSeparatedByString:@"-"];
        NSInteger year = [year_month_day[0] integerValue];
        NSInteger month = [year_month_day[1] integerValue];
        NSInteger days = [year_month_day[2] integerValue];
        
        // calculation date's show
        if (i < firstWeekday) { // last month'date (29/28)
            
            day = daysInLastMonth - firstWeekday + i + 1;
            [self setStyle_BeyondThisMonth:dayButton];
            
            // the special date in last month like: Dec
            nowStr = [NSString stringWithFormat:@"%ld-%0.2ld-%0.2ld",year,month-1,day];
            if(month == 1) {
                nowStr = [NSString stringWithFormat:@"%ld-12-%0.2ld",year,day];
            }
            
        }
        else if (i > firstWeekday + daysInThisMonth - 1){ // next month'date (1、2)
            
            day = i + 1 - firstWeekday - daysInThisMonth;
            [self setStyle_BeyondThisMonth:dayButton];
            
            // the special date in next month like: Jan
            nowStr = [NSString stringWithFormat:@"%ld-%0.2ld-%0.2ld",year,month+1,day];
            if(month == 12) {
                nowStr = [NSString stringWithFormat:@"%ld-01-%0.2ld",year,day];
            }
            
        }
        else{ // this month（1、2...）
            
            day = i - firstWeekday + 1;
            [self setStyle_AfterToday:dayButton];
            
            nowStr = [NSString stringWithFormat:@"%@-%0.2li",[now substringToIndex:7],day];
            
        }
        
        [dayButton setTitle:[NSString stringWithFormat:@"%li", day] forState:UIControlStateNormal];
        
#warning the date include last month、this month、next month
        NSDate *chineseCalendarDate = [self dateFromString:nowStr];
        NSString *nowDate = [self getChineseCalendarWithDate:chineseCalendarDate];
        UILabel *chineseCalendar = [[UILabel alloc] initWithFrame:CGRectMake(0, dayButton.bottom, view.width, 17)];
        [view addSubview:chineseCalendar];
        chineseCalendar.textAlignment = 1;
        chineseCalendar.textColor = RGB(210, 210, 210);
        chineseCalendar.font = [UIFont systemFontOfSize:10.f];
        chineseCalendar.text = nowDate;
        
        // view's click
        [view setTitle:nowStr forState:0];
        [view addTarget:self action:@selector(dateTouch:) forControlEvents:UIControlEventTouchUpInside];
        
        
        // this month
        if ([self month:date] == [self month:[NSDate date]]) {
            NSInteger todayIndex = [self day:date] + firstWeekday - 1;
            if (i < todayIndex && i >= firstWeekday) {
                NSString *str = [NSString stringWithFormat:@"%0.2ld",i - (firstWeekday - 1)];
                
                // if _signedArray include str ,sign dayButton
                if([_signedArray containsObject:str]){
                    [self setStyle_BeforeToday:dayButton andIsSign:YES];
                }
                
            }
            else if(i ==  todayIndex){
                _signButton = dayButton;
                NSString *str = [NSString stringWithFormat:@"%ld",i - (firstWeekday - 1)];
                if([_signedArray containsObject:str]){
                    [self setStyle_Today:dayButton andIsSign:YES];
                }
                else{
                    [self setStyle_Today:dayButton andIsSign:NO];
                }
            }
        }
        
    }
    
}

#pragma mark date touch
- (void)dateTouch:(UIButton *)sender {
    
    UIButton *button = (UIButton *)sender;
    NSString *date = button.titleLabel.text;
    if(self.block) {
        
        self.block(date);
    }
}


#pragma mark - date button style

// the date not't in this month
- (void)setStyle_BeyondThisMonth:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:RGB(210, 210, 210) forState:UIControlStateNormal];
}

// the date has past in this month
- (void)setStyle_BeforeToday:(UIButton *)btn andIsSign:(BOOL )sign
{
    btn.enabled = NO;
    if(sign){
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:RGBAlpha(21, 170, 155, 1.0)];
    }
    else{
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:RGB(138, 138, 138)];
    }
    //[btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

// today
- (void)setStyle_Today:(UIButton *)btn andIsSign:(BOOL )sign
{
    btn.enabled = NO;
    if(sign){
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:RGBAlpha(21, 170, 155, 1.0)];
    }
    else{
        [btn setTitleColor:RGB(143, 143, 143) forState:UIControlStateNormal];
        btn.layer.borderWidth = 1.0;
        btn.layer.borderColor = RGBAlpha(21, 170, 155, 1.0).CGColor;
        [btn setBackgroundColor:[UIColor clearColor]];
    }
}

// sign today
- (void)signToday
{
    [_signButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_signButton setBackgroundColor:RGBAlpha(21, 170, 155, 1.0)];
}

// the date will come of this month
- (void)setStyle_AfterToday:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:RGB(143, 143, 143) forState:UIControlStateNormal];
}

#pragma mark - date
- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}

- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}

- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}

- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

// dateString -> date
- (NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"YYYY-MM-dd"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}

// get Chinese calendar
- (NSString *)getChineseCalendarWithDate:(NSDate *)date{
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    // The default return date (2, 5,...), when today is the first show in that month (February, may...).
    NSString *chineseCal_str = d_str;
    if([chineseMonths containsObject:m_str] && [d_str isEqualToString:@"初一"]) {
        chineseCal_str = m_str;
    }
    else if ([m_str isEqualToString:@"正月"] && [d_str isEqualToString:@"初一"]) {
        chineseCal_str = @"春节";
    }
    else if ([m_str isEqualToString:@"正月"] && [d_str isEqualToString:@"十五"]) {
        chineseCal_str = @"元宵节";
    }
    else if ([m_str isEqualToString:@"五月"] && [d_str isEqualToString:@"初五"]) {
        chineseCal_str = @"端午节";
    }
    else if ([m_str isEqualToString:@"八月"] && [d_str isEqualToString:@"十五"]) {
        chineseCal_str = @"中秋节";
    }
    else if ([m_str isEqualToString:@"九月"] && [d_str isEqualToString:@"初九"]) {
        chineseCal_str = @"重阳节";
    }
    else if ([m_str isEqualToString:@"腊月"] && [d_str isEqualToString:@"初八"]) {
        chineseCal_str = @"腊八节";
    }
    
    // Extensions: display the holidays
    NSDictionary *Holidays = @{@"01-01":@"元旦",
                               @"02-14":@"情人节",
                               @"03-08":@"妇女节",
                               @"03-12":@"植树节",
                               @"05-01":@"劳动节",
                               @"05-04":@"青年节",
                               @"06-01":@"儿童节",
                               @"07-01":@"建党节",
                               @"08-01":@"建军节",
                               @"09-10":@"教师节",
                               @"10-01":@"国庆节",
                               @"12-24":@"平安夜",
                               @"12-25":@"圣诞节"};
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM-dd";
    NSString *nowStr = [dateFormatter stringFromDate:date];
    
    NSArray *array = [Holidays allKeys];
    if([array containsObject:nowStr]) {
        
        chineseCal_str = [Holidays objectForKey:nowStr];
    }
    
    return chineseCal_str;
}


- (NSString *)getDateForNowWithFormatter:(NSString *)formatter {
    if(formatter){
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //dateFormatter.dateFormat = @"YYYY年MM月dd日";
        dateFormatter.dateFormat = formatter;
        NSString *nowStr = [dateFormatter stringFromDate:now];
        return nowStr;
    }
    else{
        return @"参数错误";
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


@end
