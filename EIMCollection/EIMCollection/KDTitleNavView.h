//
//  KDTitleNavView.h
//  EIMCollection
//
//  Created by swb on 2016/11/15.
//  Copyright © 2016年 EIM. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol KDTitleNavViewDelegate <NSObject>
-(void)clickTitle:(NSString *)title inIndex:(int)index;
-(void)clickArrowSinceIndex:(int)sinceIndex toIndex:(int)toIndex;
@end


@interface KDTitleNavView : UIView
@property(nonatomic,strong) NSArray *titleArray;
@property(nonatomic,strong) NSMutableArray *titleViewArray;
@property(nonatomic,strong) UIColor *titleColor;
@property(nonatomic,strong) UIColor *selectedColor;
@property(nonatomic,assign) int currentIndex;
@property(nonatomic,copy) NSString *currentTitle;
@property(nonatomic,weak) id<KDTitleNavViewDelegate> delegate;



@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIButton *rollView;
@property(nonatomic,strong) UIView *selectView;
@property(nonatomic,strong) UIView *lineView;


@property(nonatomic,assign) BOOL isFillWidth;//是否满屏显示
@end

