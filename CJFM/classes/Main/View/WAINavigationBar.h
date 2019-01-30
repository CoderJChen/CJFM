//
//  WAINavigationBar.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/24.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAINavigationBar : UINavigationBar

/**
 *设置全局的导航栏背景
 *@param globalImg 全局背景图片
 */
+ (void)setGlobalBackGroundImage:(UIImage *)globalImg;


/**
 设置导航l字体及颜色
 
 @param globalTextColor 全局t字体颜色
 @param fontSize 字体大小
 */
+ (void)setGlobalTextColor:(UIColor *)globalTextColor andFontSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
