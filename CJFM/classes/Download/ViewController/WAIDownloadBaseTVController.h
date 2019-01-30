//
//  WAIDownloadBaseTVController.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/29.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WAINoDlownloadView.h"
NS_ASSUME_NONNULL_BEGIN

@interface WAIDownloadBaseTVController : UITableViewController

/**
 *  是否显示无数据面板
 */
@property (nonatomic, assign) BOOL showNoDataPane;

- (WAINoDownloadViewType)nodownLoadViewType;

@end

NS_ASSUME_NONNULL_END
