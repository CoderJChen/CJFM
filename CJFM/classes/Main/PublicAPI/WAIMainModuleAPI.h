//
//  WAIMainModuleAPI.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/25.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAIMainModuleAPI : NSObject

/**
 获取控制器

 @return rootTabBarController
 */
+ (UITabBarController *)rootTabBarController;

/**
 添加子控制器
 
 @param vc 子控制器
 @param normalImageName 普通状态下图片
 @param selectImgName 点击选中状态下图片
 @param isrequired 是否需要包装导航栏
 */
+ (void)addChildVC:(UIViewController *)vc normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectImgName isRequiredNavController:(BOOL)isrequired;


/**
 设置tabbar中间控件的点击代码块

 @param middleClickBlock middleClickBlock 点击代码块
 */
+ (void)setTabbarMiddleBtnClick:(void(^)(BOOL isPlaying))middleClickBlock;

/**
 设置全局导航背景图片

 @param globalImage 全局导航背景图片
 */
+ (void)setNavBarGlobalBackGroundImage:(UIImage *)globalImage;

/**
 设置全局导航栏背景图片

 @param globalTextColor 全局导航栏标题颜色
 @param fontSize 全局导航栏字体大小
 */
+ (void)setNavBarGlobalTextColor:(UIColor *)globalTextColor andFontSize:(CGFloat)fontSize;

/**
 快速获取中间按钮

 @return 中间按钮，通过通知  playStatus ，playImage  控制 播放和播放图片
 */
+ (UIView *)middleView;

@end

NS_ASSUME_NONNULL_END
