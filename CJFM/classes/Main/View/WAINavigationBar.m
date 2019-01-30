//
//  WAINavigationBar.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/24.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAINavigationBar.h"

@implementation WAINavigationBar
+ (void)setGlobalBackGroundImage:(UIImage *)globalImg{
    UINavigationBar * navBar = [UINavigationBar appearanceWhenContainedIn:NSClassFromString(@"WAINavigationController"), nil];
    [navBar setBackgroundImage:globalImg forBarMetrics:UIBarMetricsDefault];
}


+ (void)setGlobalTextColor:(UIColor *)globalTextColor andFontSize:(CGFloat)fontSize{
    if (globalTextColor == nil) {
        return;
    }
    if (fontSize < 6 || fontSize > 40) {
        fontSize = 16;
    }
    UINavigationBar * navBar = [UINavigationBar appearanceWhenContainedIn:NSClassFromString(@"WAINavigationController"), nil];
//    h设置导航栏颜色字体
    NSDictionary * titleDict = @{
                                 NSForegroundColorAttributeName : globalTextColor,
                                 NSFontAttributeName : [UIFont systemFontOfSize:fontSize]
                                 };
    [navBar setTitleTextAttributes:titleDict];
}
@end
