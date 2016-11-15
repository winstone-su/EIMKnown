//
//  EIMCollectionViewCell.m
//  EIMCollection
//
//  Created by swb on 2016/11/14.
//  Copyright © 2016年 EIM. All rights reserved.
//

#import "EIMCollectionViewCell.h"
#import "UIButton+CollectionCellStyle.h"

@implementation EIMCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (id)sharedInit {
    [self setup];
    return self;
}

- (void)setup
{
    
    self.button = [EIMIndexPathButton buttonWithType:UIButtonTypeCustom];
    self.button.userInteractionEnabled = NO;
    self.button.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self.contentView addSubview:self.button];
    
    
    [self.button eim_greenStyle];
}

@end
