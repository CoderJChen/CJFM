//
//  WAIMiddleView.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/24.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN



@interface WAIMiddleView : UIView

+ (instancetype)shareInstance;

+ (instancetype)middleView;

@property(assign,nonatomic) BOOL  isPlaying;

@property(nonatomic,strong) UIImage * middleImg;

@property(copy,nonatomic) void (^middleClickBlock)(BOOL isplaying);

@end

NS_ASSUME_NONNULL_END
