//
//  WAISegmentViewController.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/26.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WAISegmentBar.h"
#import "NSString+SegmentModelProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface WAISegmentViewController : UIViewController
@property (nonatomic,weak) WAISegmentBar * segmentBar;

- (void)setUpWithItems:(NSArray <id<WAISegmentModelProtocol>>*)items childVC:(NSArray <UIViewController *>*)childVCs;

@end

NS_ASSUME_NONNULL_END
