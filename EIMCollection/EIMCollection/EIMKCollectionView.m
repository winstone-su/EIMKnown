//
//  EIMKCollectionView.m
//  EIMCollection
//
//  Created by swb on 2016/11/15.
//  Copyright © 2016年 EIM. All rights reserved.
//

#import "EIMKCollectionView.h"
#import "EIMCollectionViewCell.h"
#import "EIMCollectionHeaderView.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "EIMKCategoryPopview.h"

static float const kControllerHeaderViewHeight                = 90.f;
static float const kControllerHeaderToCollectionViewMargin    = 0;
static float const kCollectionViewCellsHorizonMargin          = 12;
static float const kCollectionViewCellHeight                  = 30;
static float const kCollectionViewItemButtonImageToTextMargin = 5;

static float const kCollectionViewToLeftMargin                = 16;
static float const kCollectionViewToTopMargin                 = 12;
static float const kCollectionViewToRightMargin               = 16;
static float const kCollectionViewToBottomtMargin             = 10;

static float const kCellBtnCenterToBorderMargin               = 19;

#define  CYLTagTitleFont [UIFont systemFontOfSize:16]


static NSString * const kCellIdentifier           = @"CellIdentifier";
static NSString * const kHeaderViewCellIdentifier = @"HeaderViewCellIdentifier";
typedef void(^ISLimitWidth)(BOOL yesORNo, id data);

@implementation EIMKCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)reload
{
    [self reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
    return [self initWithFrame:frame collectionViewLayout:layout];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if(self){
        NSLog(@"%@",NSStringFromCGRect(frame));
        self.backgroundColor = [UIColor redColor];
        [self registerClass:[EIMCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
         [self registerClass:[EIMCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewCellIdentifier];
        self.delegate = self;
        self.dataSource = self;
        self.allowsMultipleSelection = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.contentInset = UIEdgeInsetsMake(20, 0, 0, 20);
    }
    
    return self;
}


#pragma mark - 🔌 UICollectionViewDelegate Method

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        EIMCollectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewCellIdentifier" forIndexPath:indexPath];
        view.titleLabel.text = @"运维知识";
        return view;
    }
    return nil;
}

#pragma mark - 🔌 UICollectionViewDataSource Method

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //    return [self.dataSource count];
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return section * 3  + 2;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EIMCollectionViewCell *cell =
    (EIMCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier
                                                                       forIndexPath:indexPath];
    
    cell.button.frame = CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame));
//    NSLog(@"%@",NSStringFromCGSize(cell.button.frame.size));
    NSString *text = @"网络工程";
    [cell.button setTitle:text forState:UIControlStateNormal];
    [cell.button setTitle:text forState:UIControlStateSelected];
    
    
    //    if (indexPath.row == 0) {
    UIImage *image = [UIImage imageNamed:@"home_btn_shrink"];
    [cell.button setImage:image
                 forState:UIControlStateNormal];
//    CGFloat spacing = kCollectionViewItemButtonImageToTextMargin;
    cell.button.titleEdgeInsets = UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width);
    CGSize size = [text sizeWithAttributes:
                   @{NSFontAttributeName:
                         CYLTagTitleFont}];
//    NSLog(@"%@,%@",text,NSStringFromCGSize(size));
    cell.button.imageEdgeInsets = UIEdgeInsetsMake(0, size.width, 0, -size.width);
    //    } else {
    //        [cell.button setImage:nil forState:UIControlStateNormal];
    //        cell.button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    //        cell.button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    //    }
    //    cell.button.selected = YES;
    cell.button.section = indexPath.section;
    cell.button.row = indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EIMCollectionViewCell *cell =
    (EIMCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.button.selected = !cell.button.isSelected;
    
    [self reloadItemsAtIndexPaths:@[indexPath]];
    
    EIMKCategoryPopview *popView = [[EIMKCategoryPopview alloc] init];
    [popView showInView:[UIApplication sharedApplication].keyWindow];
    
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
    NSString *text = @"网络工程";
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



@end
