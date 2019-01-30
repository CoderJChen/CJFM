//
//  WAIMainModuleAPI.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/25.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAIMainModuleAPI.h"
#import "WAITabBarController.h"
#import "WAINavigationController.h"
#import "WAITabBar.h"
#import "WAINavigationBar.h"
#import "WAIMiddleView.h"
@implementation WAIMainModuleAPI

+ (UITabBarController *)rootTabBarController{
    return [WAITabBarController shareInstance];
}

+ (void)addChildVC:(UIViewController *)vc normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectImgName isRequiredNavController:(BOOL)isrequired{
    [[WAITabBarController shareInstance] addChildVC:vc normalImageName:normalImageName selectedImageName:selectImgName isRequiredNavController:isrequired];
}

+(void)setTabbarMiddleBtnClick:(void (^)(BOOL))middleClickBlock{
    WAITabBar * tabbar = (WAITabBar *)[WAITabBarController shareInstance].tabBar;
    tabbar.middleDidClick = middleClickBlock;
}

+ (void)setNavBarGlobalBackGroundImage:(UIImage *)globalImage{
    [WAINavigationBar setGlobalBackGroundImage:globalImage];
}

+ (void)setNavBarGlobalTextColor:(UIColor *)globalTextColor andFontSize:(CGFloat)fontSize{
    [WAINavigationBar setGlobalTextColor:globalTextColor andFontSize:fontSize];
}

+(UIView *)middleView{
    return [WAIMiddleView shareInstance];
}
@end
