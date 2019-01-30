//
//  WAITodayFireVC.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/29.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAITodayFireVC.h"
#import "WAISegmentBar.h"

#import "WAICategoryModel.h"
#import "WAITodayFireVoiceListVC.h"
#import "WAIDownLoadDataTool.h"

@interface WAITodayFireVC ()<WAISegmentBarDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) WAISegmentBar * segmentBar;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) NSArray<WAICategoryModel *> *categoryMs;
@end

@implementation WAITodayFireVC
-(WAISegmentBar *)segmentBar{
    if (!_segmentBar) {
        WAISegmentBarConfig * config = [WAISegmentBarConfig defaultConfig];
        config.isShowMore = YES;
        config.segmentBarBackColor = [UIColor whiteColor];
        _segmentBar = [WAISegmentBar segmentBarWithConfig:config];
        _segmentBar.delegate = self;
        _segmentBar.y = WAIGetRectNavAndStatusHight;
    }
    return _segmentBar;
}
-(UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, WAIGetRectNavAndStatusHight + self.segmentBar.height, WAIScreenWidth, WAIScreenHeight - (WAIGetRectNavAndStatusHight + self.segmentBar.height))];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.bounces = NO;
        scrollView.contentSize = CGSizeMake(scrollView.width * self.childViewControllers.count, 0);
        _contentScrollView = scrollView;
    }
    return _contentScrollView;
}
- (void)setCategoryMs:(NSArray<WAICategoryModel *> *)categoryMs{
    _categoryMs = categoryMs;
    [self setUpWithItems:[categoryMs valueForKeyPath:@"name"]];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"今日最火";
    self.view.tag = 666;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WAICommonColor;
    
    // 2. 添加内容视图
    [self.view addSubview:self.contentScrollView];
    
    // 1. 设置菜单栏
    [self.view addSubview:self.segmentBar];
   
    
    WAIWeakSelf;
    [[WAIDownLoadDataTool shareInstance]getTodayFireShareAndCategoryData:^(WAIShareModel * _Nonnull shareM, NSArray<WAICategoryModel *> * _Nonnull categoryMs) {
        weakSelf.categoryMs = categoryMs;
    }];
}
- (void)setUpWithItems:(NSArray <NSString *>*)items {
    // 0.添加子控制器
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    for (int i = 0; i < items.count; i++) {
        WAITodayFireVoiceListVC *vc = [[WAITodayFireVoiceListVC alloc] init];
        vc.view.backgroundColor = WAIRandomColor;
        [self addChildViewController:vc];
    }
    // 1. 设置菜单项展示
    self.segmentBar.segmentMs = items;
    
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.width * items.count, 0);
    
    self.segmentBar.selectIndex = 0;
}

- (void)showControllerView:(NSInteger)index {
    
    WAITodayFireVoiceListVC * listVC = self.childViewControllers[index];
    listVC.loadKey = self.categoryMs[index].key;
    UIView *view = listVC.view;
    CGFloat contentViewW = self.contentScrollView.width;
    view.frame = CGRectMake(contentViewW * index, 0, contentViewW, self.contentScrollView.height);
    [self.contentScrollView addSubview:view];
    [self.contentScrollView setContentOffset:CGPointMake(contentViewW * index, 0) animated:YES];
    
}

-(void)segmentBar:(WAISegmentBar *)segmentBar didSelectedWithIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex{
    [self showControllerView:toIndex];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger page = scrollView.contentOffset.x / scrollView.width;
    self.segmentBar.selectIndex = page;
    
}

@end
