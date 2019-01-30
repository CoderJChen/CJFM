//
//  CALayer+WAIPauseAnimate.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/24.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (WAIPauseAnimate)

/**
 暂停动画
 */
- (void)pauseAnimate;

/**
 恢复动画
 */
- (void)resumeAnimate;
@end

NS_ASSUME_NONNULL_END
