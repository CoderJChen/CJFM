//
//  WAITabBarController.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/24.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAITabBarController.h"
#import "WAITabBar.h"
#import "WAIMiddleView.h"
#import "WAINavigationController.h"
#import "UIImage+WAIImage.h"

@interface WAITabBarController ()

@end

@implementation WAITabBarController
+ (instancetype)shareInstance{
    static WAITabBarController * _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[WAITabBarController alloc]init];
    });
    return _instance;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    设置tabbar
    [self setUpInit];
}
- (void)setUpInit{
    [self setValue:[[WAITabBar alloc]init] forKeyPath:@"tabBar"];
}
+ (instancetype)tabBarControllerWithAddChildVCsBlock:(void (^)(WAITabBarController * _Nonnull tabBar))addVCBlock{
    WAITabBarController * tabBarVC = [[WAITabBarController alloc]init];
    if (addVCBlock) {
        addVCBlock(tabBarVC);
    }
    return tabBarVC;
}
- (void)addChildVC:(UIViewController *)vc normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectImgName isRequiredNavController:(BOOL)isrequired{
    if (isrequired) {
        WAINavigationController * nav = [[WAINavigationController alloc]initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"" image:[UIImage originImageWithName:normalImageName] selectedImage:[UIImage originImageWithName:selectImgName]];
        [self addChildViewController:nav];
    }else{
        [self addChildViewController:vc];
    }
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    UIViewController * vc = self.childViewControllers[selectedIndex];
    if (vc.view.tag == 666) {
        vc.view.tag = 888;
        WAIMiddleView * middleView = [WAIMiddleView middleView];
        middleView.middleClickBlock = [WAIMiddleView shareInstance].middleClickBlock;
        middleView.middleImg = [WAIMiddleView shareInstance].middleImg;
        middleView.isPlaying = [WAIMiddleView shareInstance].isPlaying;
        
        CGRect frame = middleView.frame;
        frame.size.width = 65;
        frame.size.height = 65;
//        middleView.centerX = self.tabBar.centerX;
//        middleView.centerY = self.tabBar.centerY;
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        frame.origin.x = (screenSize.width - 65) * 0.5;
        frame.origin.y = screenSize.height - 65;
        middleView.frame = frame;
        [vc.view addSubview:middleView];
    }
}
@end
