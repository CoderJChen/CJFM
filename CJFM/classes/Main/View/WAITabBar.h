//
//  WAITabBar.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/24.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAITabBar : UITabBar

@property(copy,nonatomic) void(^middleDidClick)(BOOL isPlaying);

@end

NS_ASSUME_NONNULL_END
