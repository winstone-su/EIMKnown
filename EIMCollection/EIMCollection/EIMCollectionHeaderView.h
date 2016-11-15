//
//  EIMCollectionHeaderView.h
//  EIMCollection
//
//  Created by swb on 2016/11/14.
//  Copyright © 2016年 EIM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EIMCollectionHeaderViewDelegate <NSObject>

- (void)collectionHeaderViewBtnClick:(id)data;
@end

@interface EIMCollectionHeaderView : UICollectionReusableView


@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIImageView *image;
@property(nonatomic,strong) UIButton *closeBtn;

@property(nonatomic,assign) id<EIMCollectionHeaderViewDelegate> delegate;

@property(nonatomic,assign) BOOL isShowBtn;



@end
