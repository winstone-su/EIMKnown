//
//  EIMCollectionViewCell.h
//  EIMCollection
//
//  Created by swb on 2016/11/14.
//  Copyright © 2016年 EIM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EIMIndexPathButton.h"

@interface EIMCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) EIMIndexPathButton *button;
@property (nonatomic, assign) NSUInteger         section;
@property (nonatomic, assign) NSUInteger         row;
@property (nonatomic, assign) BOOL               shouldShow;

@end
