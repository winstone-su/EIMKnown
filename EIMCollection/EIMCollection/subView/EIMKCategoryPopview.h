//
//  EIMKCategoryPopview.h
//  EIMCollection
//
//  Created by swb on 2016/11/15.
//  Copyright © 2016年 EIM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EIMKCategoryPopview : UIView

@property(nonatomic,strong) UICollectionView *collectionView;



- (void)showInView:(UIView *)view;
- (void)disMissView;


@end
