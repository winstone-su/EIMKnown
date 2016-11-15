//
//  ViewController.m
//  EIMCollection
//
//  Created by swb on 2016/11/14.
//  Copyright © 2016年 EIM. All rights reserved.
//

#import "ViewController.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "EIMCollectionViewCell.h"
#import "EIMCollectionHeaderView.h"
#import "EIMKCollectionView.h"
#import "KDTitleNavView.h"
#import "EIMKCategoryPopview.h"

static float const kControllerHeaderViewHeight                = 50.f;
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

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,KDTitleNavViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIScrollView     *backgroundView;
@property (nonatomic, strong) NSArray          *dataSource;
@property (nonatomic,strong) NSString *testStringTitle;
@property (nonatomic,strong)  EIMKCategoryPopview *popView;
@property (nonatomic,strong) UIView *topView;

@property(nonatomic,strong) KDTitleNavView *titleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"分类";
    self.testStringTitle = @"网络工程";
    
//    self.backgroundView = [[UIScrollView alloc] initWithFrame:
//                           CGRectMake(0, 0,
//                                      [UIScreen mainScreen].bounds.size.width,
//                                      [UIScreen mainScreen].bounds.size.height)
//                           ];
//    self.backgroundView.showsVerticalScrollIndicator = NO;
//    self.backgroundView.alwaysBounceVertical = YES;
//    self.backgroundView.backgroundColor = [UIColor colorWithRed:252.0f / 255.f green:252.0f / 255.f blue:252.0f / 255.f alpha:2.f];
//    self.backgroundView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.backgroundView];
    
    
    [self addCollectionView];
    [self.view addSubview:self.titleView];
    
//    [self.collectionView reloadData];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
//    [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
//    CGRect collectionViewFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
//                                            [UIScreen mainScreen].bounds.size.height- 90.f);
//    EIMKCollectionView *eimCollection = [[EIMKCollectionView alloc] initWithFrame:collectionViewFrame];
//    
//    [self.view addSubview:eimCollection];
//    [eimCollection reload];

//    [self.view addSubview:self.topView];
//    [self.view addSubview:self.titleView];
    self.titleView.titleArray = @[@"运维知识",@"终端知识",@"信息知识",@"网络知识"];
//    [self addCollectionView];
}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectZero];
        _topView.frame = CGRectMake(0, 64,self.view.frame.size.width, kControllerHeaderViewHeight + 20);
        _topView.backgroundColor = [UIColor redColor];
    }
    
    return _topView;
}


- (KDTitleNavView *)titleView
{
    if(!_titleView){
        CGRect size = CGRectMake(0, 64,self.view.frame.size.width, kControllerHeaderViewHeight);
        _titleView = [[KDTitleNavView alloc] initWithFrame:size];
        _titleView.isFillWidth = YES;
//        _titleView.backgroundColor = [UIColor blueColor];
        _titleView.delegate = self;
    }
    
    return _titleView;
}

- (void)addCollectionView {
    CGRect collectionViewFrame = CGRectMake(0, kControllerHeaderViewHeight + kControllerHeaderToCollectionViewMargin, [UIScreen mainScreen].bounds.size.width,
                                            [UIScreen mainScreen].bounds.size.height);
    NSLog(@"%@",NSStringFromCGRect(collectionViewFrame));
    UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame
                                             collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[EIMCollectionViewCell class]
            forCellWithReuseIdentifier:kCellIdentifier];
    self.collectionView.allowsMultipleSelection = YES;
    [self.collectionView registerClass:[EIMCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewCellIdentifier];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    self.collectionView.scrollsToTop = NO;
    self.collectionView.scrollEnabled = NO;
    [self.view addSubview:self.collectionView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 3;
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
    NSLog(@"%@",NSStringFromCGSize(cell.button.frame.size));
    NSString *text = self.testStringTitle;
    [cell.button setTitle:text forState:UIControlStateNormal];
    [cell.button setTitle:text forState:UIControlStateSelected];
    
    
//    if (indexPath.row == 0) {
        UIImage *image = [UIImage imageNamed:@"home_btn_shrink"];
        [cell.button setImage:image
                     forState:UIControlStateNormal];
        CGFloat spacing = kCollectionViewItemButtonImageToTextMargin;
        cell.button.titleEdgeInsets = UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width);
        CGSize size = [text sizeWithAttributes:
                       @{NSFontAttributeName:
                             CYLTagTitleFont}];
        NSLog(@"%@,%@",text,NSStringFromCGSize(size));
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
    
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
    if(!_popView){
        _popView  = [[EIMKCategoryPopview alloc] initWithFrame:self.view.frame];
    }
    
    [_popView showInView:[UIApplication sharedApplication].keyWindow];
    
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
    float limitWidth = (CGRectGetWidth(self.collectionView.frame) - kCollectionViewToLeftMargin - kCollectionViewToRightMargin - limitMargin);
    if (cellWidth >= limitWidth) {
        cellWidth = limitWidth;
        isLimitWidth ? isLimitWidth(YES, @(cellWidth)) : nil;
        return cellWidth;
    }
    isLimitWidth ? isLimitWidth(NO, @(cellWidth)) : nil;
    return cellWidth;
}


#pragma mark  KDTitleNavView Delegate
-(void)clickTitle:(NSString *)title inIndex:(int)index
{
    self.testStringTitle = title;
//    [self.collectionView reloadData];
}

-(void)clickArrowSinceIndex:(int)sinceIndex toIndex:(int)toIndex
{
    
}





@end
