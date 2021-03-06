//
//  KDTitleNavView.m
//  EIMCollection
//
//  Created by swb on 2016/11/15.
//  Copyright © 2016年 EIM. All rights reserved.
//

#import "KDTitleNavView.h"

#define TitleCount 4
#define ArrowWidth 40
#define TitleSpaceWidth 30
#define TitleWidth ((self.bounds.size.width-ArrowWidth)/TitleCount)
#define TitleHeight self.bounds.size.height*0.9
#define SelectViewHeight 1.2
#define RGBCOLOR(r, g, b)			[UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
@implementation KDTitleNavView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
//        self.titleColor = RGBCOLOR(138.f, 138.f, 138.f);
        self.titleColor = [self getColor:@"333333"];
        self.selectedColor = [self getColor:@"2fc762"];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = RGBCOLOR(250.f, 250.f, 250.f);
        self.titleColor = RGBCOLOR(138.f, 138.f, 138.f);
        self.selectedColor = RGBCOLOR(25.f, 133.f, 255.f);
    }
    return self;
}


-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    if(self.scrollView)
        [self.scrollView removeFromSuperview];
    
    //滚动视图
    CGRect rect = self.bounds;
    if(self.isFillWidth)
        rect.size.width = self.bounds.size.width;
    else
        rect.size.width = self.bounds.size.width - ArrowWidth;
    self.scrollView = [[UIScrollView alloc] initWithFrame:rect];
    self.scrollView.scrollEnabled = !self.isFillWidth;
    //self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.backgroundColor = self.backgroundColor;
    self.scrollView.contentSize = CGSizeMake(titleArray.count*TitleWidth+100, rect.size.height);
    
    //标题按钮数组
    _titleViewArray = [[NSMutableArray alloc] initWithCapacity:titleArray.count];
    // double titleWidth = TitleWidth;
    double titleHeight = TitleHeight;
    __weak KDTitleNavView *selfInBlock = self;
    [titleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //标题按钮
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.titleLabel.font = [UIFont fontWithName:nil size:14];
        titleButton.titleLabel.lineBreakMode = NSLineBreakByClipping;
        [titleButton setTitle:obj forState:UIControlStateNormal];
        [titleButton setTitleColor:self.titleColor forState:UIControlStateNormal];
        [titleButton setTitleColor:self.selectedColor forState:UIControlStateHighlighted];
        [titleButton setTitleColor:self.selectedColor forState:UIControlStateSelected];
        CGRect titleFrame = CGRectMake([selfInBlock getTitleX:idx], 0, [self getTitleWidth:idx], titleHeight);
        titleButton.frame = titleFrame;
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [selfInBlock.titleViewArray addObject:titleButton];
        [selfInBlock.scrollView addSubview:titleButton];
        
        //分隔符,最后一个不要分隔符
        if(idx!=titleArray.count-1)
        {
            UIView *spiltView = [[UIView alloc] initWithFrame:CGRectMake([selfInBlock getTitleX:idx+1],titleHeight*0.25 , 0.5, titleHeight*0.5)];
            spiltView.backgroundColor = RGBCOLOR(221.f, 221.f, 221.f);
            [selfInBlock.scrollView addSubview:spiltView];
        }
    }];
    [self addSubview:self.scrollView];
    
    //下方分割线
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width,0.5)];
    self.lineView.backgroundColor = self.backgroundColor;
    [self addSubview:self.lineView];
    
    
    //选中指示视图
    self.selectView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - SelectViewHeight, 0, SelectViewHeight)];
    self.selectView.backgroundColor = self.selectedColor;
    [self.scrollView addSubview:self.selectView];
    
    //左移视图
    if(!self.isFillWidth)
    {
        self.rollView = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.rollView setTitle:@">" forState:UIControlStateNormal];
        [self.rollView setTitleColor:RGBCOLOR(221.f, 221.f, 221.f) forState:UIControlStateNormal];
        [self.rollView setTitleColor:self.selectedColor forState:UIControlStateHighlighted];
        self.rollView.frame = CGRectMake(self.bounds.size.width - ArrowWidth, 0, ArrowWidth, TitleHeight);
        [self.rollView addTarget:self action:@selector(arrowClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rollView];
    }
}


-(void)setCurrentIndex:(int)currentIndex
{
    if(currentIndex<self.titleViewArray.count && currentIndex>=0)
    {
        UIButton *button = self.titleViewArray[currentIndex];
        [self titleClick:button];
        _currentIndex = currentIndex;
    }
    else
        self.currentIndex = 0;
}

-(void)setCurrentTitle:(NSString *)currentTitle
{
    int index = [self.titleArray indexOfObject:currentTitle];
    self.currentIndex = index;
    _currentTitle = currentTitle;
}

-(void)scrollTitleVisable:(int)currentIndex
{
    //假如标题完全在可视范围内，则不滚动
    CGPoint point = self.scrollView.contentOffset;
    double x = [self getTitleX:currentIndex];
    double width = [self getTitleWidth:currentIndex];
    if(x>=point.x && (self.scrollView.frame.size.width-(x-point.x))>=width-TitleSpaceWidth/2-1)
        return;
    
    
    if(currentIndex == 0)
        [self.scrollView setContentOffset:CGPointZero animated:YES];
    else if(currentIndex == 1)
        [self.scrollView setContentOffset:CGPointMake([self getTitleX:currentIndex-1] - [self getTitleX:0], 0) animated:YES];
    else
        [self.scrollView setContentOffset:CGPointMake([self getTitleX:currentIndex-1] + 1, 0) animated:YES];
}

-(void)titleClick:(UIButton *)button
{
    int index = [self.titleViewArray indexOfObject:button];
    _currentIndex = index;
    _currentTitle = self.titleArray[_currentIndex];
    
    __weak KDTitleNavView *selfInBlock = self;
    [UIView animateWithDuration:0.2 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        CGRect frame = selfInBlock.selectView.frame;
        frame.origin.x = [self getTitleX:index]+0.5;
        frame.size.width = [self getTitleWidth:index]-0.5;
        selfInBlock.selectView.frame = frame;
    }];
    
    //滚动至可见
    [self scrollTitleVisable:index];
    
    [self.titleViewArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = (UIButton *)obj;
        if(idx == index)
        {
            btn.selected = YES;
            btn.titleLabel.font = [UIFont fontWithName:nil size:15];
        }
        else
        {
            btn.selected = NO;
            btn.titleLabel.font = [UIFont fontWithName:nil size:14];
        }
    }];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickTitle:inIndex:)])
        [self.delegate clickTitle:self.titleArray[_currentIndex] inIndex:_currentIndex];
}

-(void)arrowClick:(UIButton *)button
{
    int sinceIndex = self.currentIndex;
    self.currentIndex++;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickArrowSinceIndex:toIndex:)])
        [self.delegate clickArrowSinceIndex:sinceIndex toIndex:self.currentIndex];
}


-(double)getTitleX:(int)index
{
    if(self.isFillWidth)
    {
        return index * [self getTitleWidth:index];
    }
    
    if(self.titleViewArray.count>index)
    {
        UIButton *btn = (UIButton *)self.titleViewArray[index];
        return btn.frame.origin.x;
    }
    else
    {
        if(self.titleViewArray.count == index && index!=0)
        {
            UIButton *btn = (UIButton *)self.titleViewArray[index-1];
            return btn.frame.origin.x+btn.frame.size.width;
        }
        else
        {
            //            __block double totalWidth = 0;
            //            double scrollWidth = self.scrollView.frame.size.width;
            //            //__block KDTitleNavView *selfInBlock = self;
            //            [self.titleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            //                double titleWidth = [self getTitleWidth:idx];
            //                totalWidth+=titleWidth;
            //                if(totalWidth > scrollWidth)
            //                {
            //                    totalWidth = scrollWidth - (totalWidth - titleWidth);
            //                    *stop = YES;
            //                }
            //            }];
            //if(totalWidth>TitleSpaceWidth*2)
            return 0;
            //else
            //    return totalWidth;
        }
    }
}

-(double)getTitleWidth:(int)index
{
    if(self.isFillWidth)
    {
        return self.bounds.size.width/self.titleArray.count;
    }
    
    if(self.titleArray.count>index)
    {
        NSString *title = (NSString *)self.titleArray[index];
        CGSize size = [title sizeWithFont:[UIFont fontWithName:nil size:14]];
        return size.width+TitleSpaceWidth;
    }
    return 0;
}

-(void)setIsFillWidth:(BOOL)isFillWidth
{
    _isFillWidth = isFillWidth;
    self.rollView.hidden = isFillWidth;
    self.scrollView.scrollEnabled = !isFillWidth;
}

-(UIColor *)getColor: (NSString *)hexColor
{
    hexColor = [hexColor lowercaseString];
    unsigned int red, green, blue;
    
    NSRange range;
    
    range.length = 2;
    
    range.location = 0;
    
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}
@end
