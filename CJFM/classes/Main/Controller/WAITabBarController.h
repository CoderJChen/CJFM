//
//  WAITabBarController.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/24.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAITabBarController : UITabBarController


/**
 获取单例对象

 @return WAITabBarController 对象
 */
+ (instancetype)shareInstance;
/**
 添加子控制器的block

 @param addVCBlock 添加代码块
 @return WAITabBarController
 */
+ (instancetype)tabBarControllerWithAddChildVCsBlock:(void(^)(WAITabBarController * tabBarVC))addVCBlock;

/**
 添加子控制器

 @param vc 子控制器
 @param normalImageName 普通状态下图片
 @param selectImgName 点击选中状态下图片
 @param isrequired 是否需要包装导航栏
 */
- (void)addChildVC:(UIViewController *)vc normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectImgName isRequiredNavController:(BOOL)isrequired;
@end

NS_ASSUME_NONNULL_END
