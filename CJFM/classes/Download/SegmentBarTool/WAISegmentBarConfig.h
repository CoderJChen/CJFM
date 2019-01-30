//
//  WAISegmentBarConfig.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/26.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAISegmentBarConfig : NSObject

+ (instancetype)defaultConfig;

/**
 控制器是否显示更多
 */
@property(assign,nonatomic) bool  isShowMore;
/**
 设置背景颜色
 */
@property (nonatomic,strong) UIColor * segmentBarBackColor;
/**
 设置文本常规颜色
 */
@property (nonatomic,strong) UIColor * itemNormalColor;
/**
 设置文本选中颜色
 */
@property (nonatomic,strong) UIColor * itemSelectColor;
/**
 设置文本字体
 */
@property (nonatomic,strong) UIFont * itemNormalFont;
@property (nonatomic,strong) UIFont * itemSelectFont;
/**
 设置下划线颜色、高度、宽
 */
@property (nonatomic,strong) UIColor * indicatorColor;
@property(assign,nonatomic) CGFloat  indicatorHeight;
@property(assign,nonatomic) CGFloat  indicatorExtraW;
/** 选项卡之间的最小间距 */
@property (nonatomic, assign) CGFloat limitMargin;
/**
 z设置文本常规字体颜色、选中字体颜色、下划线宽    链式编程
 */
@property(copy,nonatomic) WAISegmentBarConfig * (^itemNC)(UIColor * color);
@property(copy,nonatomic) WAISegmentBarConfig * (^itemSC)(UIColor * color);
@property(copy,nonatomic) WAISegmentBarConfig * (^itemNF)(UIFont * font);
@property(copy,nonatomic) WAISegmentBarConfig * (^itemSF)(UIFont * font);
@property(copy,nonatomic) WAISegmentBarConfig * (^indicatorEW)(CGFloat w);
@end

NS_ASSUME_NONNULL_END
