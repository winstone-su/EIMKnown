//
//  EIMKCategoryPopview.m
//  EIMCollection
//
//  Created by swb on 2016/11/15.
//  Copyright © 2016年 EIM. All rights reserved.
//

#import "EIMKCategoryPopview.h"
#import "EIMCollectionViewCell.h"
#import "EIMCollectionHeaderView.h"
#import "UICollectionViewLeftAlignedLayout.h"

#define kDEVICEHEIGHT [UIScreen mainScreen].bounds.size.height
#define kDEVICEWIDTH  [UIScreen mainScreen].bounds.size.width

#define PopViewHeight 230

static float const kCollectionViewCellHeight                  = 30;

static float const kCollectionViewToLeftMargin                = 16;
static float const kCollectionViewToRightMargin               = 16;

static float const kCellBtnCenterToBorderMargin               = 19;

#define  CYLTagTitleFont [UIFont systemFontOfSize:16]


static NSString * const kCellIdentifier           = @"CellIdentifier";
static NSString * const kHeaderViewCellIdentifier = @"HeaderViewCellIdentifier";
typedef void(^ISLimitWidth)(BOOL yesORNo, id data);

@interface EIMKCategoryPopview()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,EIMCollectionHeaderViewDelegate>
{
    NSArray *data;
}

@property (nonatomic,strong) UIView *contentView;

@end

@implementation EIMKCategoryPopview

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
        [self initContent];
    }
    
    return self;
}



- (void)initContent
{
    data = @[@"全部",@"桌面营销",@"业务营销",@"桌面营销",@"桌面营销",@"桌面营销",@"桌面营销",@"桌面营销"];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.userInteractionEnabled = YES;
    NSLog(@"%@",NSStringFromCGRect(self.frame));
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    
    [self addSubview:self.collectionView];
}


#pragma mark -- View
- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - PopViewHeight, [UIScreen mainScreen].bounds.size.width, PopViewHeight)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectionView];
    }
    
    return _contentView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        CGRect size =CGRectMake(0, [UIScreen mainScreen].bounds.size.height - PopViewHeight, [UIScreen mainScreen].bounds.size.width, PopViewHeight);
        UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:size
                                                 collectionViewLayout:layout];
        [_collectionView registerClass:[EIMCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
        [self.collectionView registerClass:[EIMCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewCellIdentifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.allowsMultipleSelection = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    }
    
    return _collectionView;
}


//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(UIView *)view
{
    if (!view)
    {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:self.collectionView];
    
    [self.collectionView setFrame:CGRectMake(0, kDEVICEHEIGHT, kDEVICEWIDTH, PopViewHeight)];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1.0;
        
        [self.collectionView setFrame:CGRectMake(0, kDEVICEHEIGHT - PopViewHeight, kDEVICEWIDTH, PopViewHeight)];
        
    } completion:nil];
}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView
{
    [self.collectionView setFrame:CGRectMake(0, kDEVICEHEIGHT - PopViewHeight, kDEVICEWIDTH, PopViewHeight)];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         self.alpha = 0.0;
                         
                         [self.collectionView setFrame:CGRectMake(0, kDEVICEHEIGHT, kDEVICEWIDTH, PopViewHeight)];
                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                         [self.collectionView removeFromSuperview];
                         
                     }];
    
}

#pragma mark - 🔌 UICollectionViewDelegate Method

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        EIMCollectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewCellIdentifier" forIndexPath:indexPath];
        view.delegate = self;
        view.titleLabel.text = @"运维知识";
        view.closeBtn.hidden = NO;
        return view;
    }
    return nil;
}

#pragma mark - 🔌 UICollectionViewDataSource Method

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //    return [self.dataSource count];
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 7;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EIMCollectionViewCell *cell =
    (EIMCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier
                                                                       forIndexPath:indexPath];
    
    cell.button.frame = CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame));
    NSString *text = [NSString stringWithFormat:@"%@%d",@"网络工程",(int)indexPath.row];
    text = [data objectAtIndex:indexPath.row];
    NSLog(@"%@,%@",text,NSStringFromCGSize(cell.button.frame.size));
    [cell.button setTitle:text forState:UIControlStateNormal];
    [cell.button setTitle:text forState:UIControlStateSelected];
    cell.button.section = indexPath.section;
    cell.button.row = indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EIMCollectionViewCell *cell =
    (EIMCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.button.selected = !cell.button.isSelected;
    
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
}

#pragma mark - 🔌 UICollectionViewDelegateLeftAlignedLayout Method

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //    NSArray *items = [NSArray arrayWithArray:[self.dataSource[indexPath.section] objectForKey:kDataSourceSectionKey]];
    //    NSString *text = [items[indexPath.row] objectForKey:kDataSourceCellTextKey];
//    NSString *text = @"网络工程";
    NSArray *text = [data objectAtIndex:indexPath.row];
    float cellWidth = [self collectionCellWidthText:text content:nil];
    return CGSizeMake(cellWidth, kCollectionViewCellHeight);
}

- (float)collectionCellWidthText:(NSString *)text content:(NSDictionary *)content {
    float cellWidth;
    CGSize size = [text sizeWithAttributes:
                   @{NSFontAttributeName:
                         CYLTagTitleFont}];
    //    NSString *picture = [content objectForKey:kDataSourceCellPictureKey];
    //    BOOL shouldShowPic = [@(picture.length) boolValue];
    //    if (shouldShowPic) {
    cellWidth = ceilf(size.width) + kCellBtnCenterToBorderMargin * 2;
    //    } else {
    //        cellWidth = ceilf(size.width) + kCellBtnCenterToBorderMargin;
    //    }
    cellWidth = [self cellLimitWidth:cellWidth
                         limitMargin:0
                        isLimitWidth:nil];
    return cellWidth;
}

- (float)cellLimitWidth:(float)cellWidth
            limitMargin:(CGFloat)limitMargin
           isLimitWidth:(ISLimitWidth)isLimitWidth {
    float limitWidth = (CGRectGetWidth(self.frame) - kCollectionViewToLeftMargin - kCollectionViewToRightMargin - limitMargin);
    if (cellWidth >= limitWidth) {
        cellWidth = limitWidth;
        isLimitWidth ? isLimitWidth(YES, @(cellWidth)) : nil;
        return cellWidth;
    }
    isLimitWidth ? isLimitWidth(NO, @(cellWidth)) : nil;
    return cellWidth;
}


#pragma  mark HeaderView Delegate
- (void)collectionHeaderViewBtnClick:(id)data
{
    [self disMissView];
}





@end
