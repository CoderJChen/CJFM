//
//  WAIDownLoadViewController.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/25.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAIDownLoadViewController.h"
#import "WAIDownloadManager.h"
#import "WAISegmentViewController.h"
#import "WAISegmentBar.h"
#import "WAIDeviceManager.h"
#import "WAIFileTool.h"
#import "WAIAlbumTVC.h"
#import "WAIVoiceTVC.h"
#import "WAIDownloadingTVC.h"


@interface WAIDownLoadViewController ()<WAISegmentBarDelegate,UIScrollViewDelegate>
@property (nonatomic,weak) WAISegmentViewController * segmentVC;
@property (nonatomic,strong) WAISegmentBar * segmentBar;
@property (nonatomic, weak) UILabel *noticeLabel;
@property (nonatomic, weak) UIScrollView *contentScrollView;
@end

@implementation WAIDownLoadViewController
-(WAISegmentBar *)segmentBar{
    if (!_segmentBar) {
        _segmentBar = [WAISegmentBar segmentBarWithConfig:[WAISegmentBarConfig defaultConfig]];
        _segmentBar.delegate = self;
    }
    return _segmentBar;
}
-(WAISegmentViewController *)segmentVC{
    if (!_segmentVC) {
        WAISegmentViewController * segmentVC = [[WAISegmentViewController alloc]init];
        [self addChildViewController:segmentVC];
        _segmentVC = segmentVC;
    }
    return _segmentVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpInit];
    
    self.navigationItem.titleView = self.segmentBar;
    self.segmentBar.segmentMs = @[@"专辑", @"声音", @"下载中"];
    self.segmentBar.selectIndex = 0;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self checkMemory];
}
- (void)checkMemory{
    NSString * freeSpace = [WAIDeviceManager freeDiskSpacebytes];
    NSString * useSpace = [WAIFileTool getSizeWithPath:NSHomeDirectory()];
    self.noticeLabel.text = [NSString stringWithFormat:@"已经占用空间%@,可用空间%@",useSpace,freeSpace];
    
}
- (void)setUpInit{
    self.view.backgroundColor = WAICommonColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addChildViewControllers];
    
    // 1. 添加占用内存横幅
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WAIGetRectNavAndStatusHight, WAIScreenWidth, 20)];
    self.noticeLabel = noticeLabel;
    noticeLabel.backgroundColor = [UIColor grayColor];
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    noticeLabel.font = [UIFont systemFontOfSize:12];
    noticeLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:noticeLabel];
    
    // 2. 添加内容视图
    // 2. 添加内容视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, WAIGetRectNavAndStatusHight + 20, WAIScreenWidth, WAIScreenHeight - (WAIGetRectNavAndStatusHight + 20 + WAITabbarHeight))];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.bounces = NO;
    self.contentScrollView = scrollView;
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.width * self.childViewControllers.count, 0);
    [self.view addSubview:scrollView];
}
- (void)addChildViewControllers{
    WAIAlbumTVC *vc1 = [[WAIAlbumTVC alloc]init];
    [self addChildViewController:vc1];
    
    WAIVoiceTVC *vc2 = [[WAIVoiceTVC alloc]init];
//    vc2.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:vc2];
    
    WAIDownloadingTVC *vc3 = [[WAIDownloadingTVC alloc]init];
//    vc3.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:vc3];
    
}
- (void)setChildVC{
    self.segmentVC.segmentBar.frame = CGRectMake(0, 88, WAIScreenWidth, 44);
    self.segmentVC.segmentBar.backgroundColor = [UIColor greenColor];
    self.segmentVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentVC.view];
    [self.view addSubview:self.segmentVC.segmentBar];
    [self.segmentVC.segmentBar updateWithConfig:^(WAISegmentBarConfig * _Nonnull config) {
        config.isShowMore = YES;
        config.segmentBarBackColor = [UIColor whiteColor];
    }];
    NSArray *items = @[@"专辑", @"声音", @"下载中"];
    // 添加几个自控制器
    // 在contentView, 展示子控制器的视图内容
    UIViewController *vc1 = [UIViewController new];
    vc1.view.backgroundColor = [UIColor redColor];
    
    UIViewController *vc2 = [UIViewController new];
    vc2.view.backgroundColor = [UIColor greenColor];
    
    UIViewController *vc3 = [UIViewController new];
    vc3.view.backgroundColor = [UIColor yellowColor];
    
    
    [self.segmentVC setUpWithItems:items childVC:@[vc1, vc2, vc3]];
}

- (void)showControllerView:(NSInteger)index {
    
    UIView *view = self.childViewControllers[index].view;
    CGFloat contentViewW = self.contentScrollView.width;
    view.frame = CGRectMake(contentViewW * index, 0, contentViewW, self.contentScrollView.height);
    [self.contentScrollView addSubview:view];
    [self.contentScrollView setContentOffset:CGPointMake(contentViewW * index, 0) animated:YES];
    
}

- (void)segmentBar:(WAISegmentBar *)segmentBar didSelectedWithIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex{
    [self showControllerView:toIndex];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger page = scrollView.contentOffset.x / scrollView.width;
    self.segmentBar.selectIndex = page;   
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSURL * url = [NSURL URLWithString:@"http://download.xmcdn.com/group52/M05/55/EF/wKgLcFxJN8PBss8CAEvV8DZ6ISQ245.aac"];
//    [[WAIDownloadManager shareInstance] downloadWithURL:url withProgressBlock:^(float progress) {
//        NSLog(@"下载进度---%f",progress);
//    } success:^(NSString * _Nonnull downloadPath) {
//        NSLog(@"%@",downloadPath);
//    } andError:^{
//        NSLog(@"下载失败");
//    }];
}


-(void)dealloc{
    // 移除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
