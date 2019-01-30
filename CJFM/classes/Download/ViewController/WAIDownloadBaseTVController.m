//
//  WAIDownloadBaseTVController.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/29.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAIDownloadBaseTVController.h"
#import "WAITodayFireVC.h"

@interface WAIDownloadBaseTVController ()
@property (nonatomic,strong) WAINoDlownloadView * noDataView;
@end

@implementation WAIDownloadBaseTVController

-(WAINoDlownloadView *)noDataView{
    if (!_noDataView) {
        _noDataView = [WAINoDlownloadView noDownloadViewWithType:self.nodownLoadViewType];
        [self.tableView addSubview:_noDataView];
    }
    return _noDataView;
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.noDataView.center = CGPointMake(WAIScreenWidth * 0.5, self.view.height * 0.5);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = WAICommonColor;
    self.tableView.tableFooterView = [UIView new];
    
    WAIWeakSelf;
    self.noDataView.clickBlock = ^{
        NSLog(@"看一看");
        WAITodayFireVC * fireVC = [[WAITodayFireVC alloc]init];
        [weakSelf.navigationController pushViewController:fireVC animated:YES];
        
    };
    
    // 监听下载状态改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:WAIDownLoadStateChangeNotification object:nil];
    
}


-(void)setShowNoDataPane:(BOOL)showNoDataPane{
    _showNoDataPane = showNoDataPane;
    self.noDataView.hidden = !_showNoDataPane;
}

- (void)loadData {
    
}

-(void)dealloc{
    // 移除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source

@end
