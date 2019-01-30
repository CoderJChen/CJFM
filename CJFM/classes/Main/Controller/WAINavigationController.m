//
//  WAINavigationController.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/24.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAINavigationController.h"
#import "WAINavigationBar.h"

@interface WAINavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation WAINavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        [self setValue:[[WAINavigationBar alloc]init] forKeyPath:@"navigationBar"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    设置手势代理
    UIGestureRecognizer * gest = self.interactivePopGestureRecognizer;
//    自定义手势
//    手势加载谁身上，手势执行谁的什么方法
    UIPanGestureRecognizer * panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self.delegate action:NSSelectorFromString(@"handleNavigationTransition:")];
//    其实就是控制器的容器视图
    [gest.view addGestureRecognizer:panGes];
    gest.delaysTouchesBegan = YES;
    panGes.delegate = self;
    
}
- (void)comeBack{
    [self popViewControllerAnimated:YES];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_back_n"] style:UIBarButtonItemStyleDone target:self action:@selector(comeBack)];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
    
}
#pragma mark -UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}

@end
