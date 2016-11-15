//
//  EIMIndexPathButton.h
//  EIMCollection
//
//  Created by swb on 2016/11/14.
//  Copyright © 2016年 EIM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EIMIndexPathButton : UIButton

@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) BOOL isShowMore; //是否有子节点


@end
