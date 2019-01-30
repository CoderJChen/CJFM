//
//  WAIMenuBarShowDetailVC.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/28.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAIMenuBarShowDetailVC.h"
#import "WAIMenuCell.h"

#define WAIRowCount 3
#define WAIMargin 6
#define WAICellH 30

@interface WAIMenuBarShowDetailVC ()

@end

@implementation WAIMenuBarShowDetailVC

static NSString * const reuseIdentifier = @"menuCell";

-(void)setItems:(NSArray<id<WAISegmentModelProtocol>> *)items{
    _items = items;
    
    NSInteger rows = (_items.count + (WAIRowCount - 1))/WAIRowCount;
    CGFloat height = rows * (WAICellH + WAIMargin);
    self.collectionView.height = height;
    self.expectedHeight = height;
    [self.collectionView reloadData];
}
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat width = (WAIScreenWidth - WAIMargin * (WAIRowCount + 1))/WAIRowCount;
        CGFloat height = WAICellH;
        flowLayout.minimumLineSpacing = WAIMargin;
        flowLayout.minimumInteritemSpacing = WAIMargin;
        flowLayout.itemSize = CGSizeMake(width, height);
//        flowLayout.sectionInset = UIEdgeInsetsMake(WAIMargin*0.5, 0, 0, 0);
    
    return [super initWithCollectionViewLayout:flowLayout];
}
- (instancetype)init{
    return [self initWithCollectionViewLayout:[UICollectionViewLayout new]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WAIMenuCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WAIMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.menueLabel.text = (NSString *)self.items[indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
