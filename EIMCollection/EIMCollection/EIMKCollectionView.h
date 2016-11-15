//
//  EIMKCollectionView.h
//  EIMCollection
//
//  Created by swb on 2016/11/15.
//  Copyright © 2016年 EIM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EIMKCollectionView : UICollectionView<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>


- (void)loadData:(id)data;

- (void)reload;

@end
