//
//  EIMCollectionHeaderView.m
//  EIMCollection
//
//  Created by swb on 2016/11/14.
//  Copyright © 2016年 EIM. All rights reserved.
//

#import "EIMCollectionHeaderView.h"

@interface EIMCollectionHeaderView()

@property(nonatomic, strong) UIView *lineView;

@end

@implementation EIMCollectionHeaderView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUp];
        
    }
    return self;
}

- (void)setUp
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.closeBtn];
}

- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    
   return  _titleLabel;
}

- (UIView *)lineView
{
    if(!_lineView){
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0,self.frame.size.height - 10, self.frame.size.width, 1)];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _lineView;
}

- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(self.frame.size.width - 40, 10,40, 20);
        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_closeBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.hidden = YES;
    }
    
    return _closeBtn;
}

-(void)buttonClick:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionHeaderViewBtnClick:)]) {
        [self.delegate collectionHeaderViewBtnClick:nil];
    }
}



- (CALayer *)cyl_addSubLayerWithFrame:(CGRect)frame color:(CGColorRef)colorRef {
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = colorRef;
    [self.layer addSublayer:layer];
    return layer;
}

@end
