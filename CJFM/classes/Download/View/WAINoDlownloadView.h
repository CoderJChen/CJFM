//
//  WAINoDlownloadView.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/29.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,WAINoDownloadViewType){
    WAINoDownloadViewTypeLoaded,
    WAINoDownloadViewTypeLoading
};
NS_ASSUME_NONNULL_BEGIN

@interface WAINoDlownloadView : UIView

@property(copy,nonatomic)void(^clickBlock)(void);

+ (instancetype)noDownloadViewWithType:(WAINoDownloadViewType)type;

@end

NS_ASSUME_NONNULL_END
