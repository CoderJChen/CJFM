//
//  WAITabBar.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/24.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAITabBar.h"
#import "WAINavigationController.h"
#import "WAIMiddleView.h"
#import "UIImage+WAIImage.h"
@interface WAITabBar()
@property (nonatomic,weak) WAIMiddleView * middleView;
@end

@implementation WAITabBar
-(WAIMiddleView *)middleView{
    if (!_middleView) {
        WAIMiddleView * middleView = [WAIMiddleView middleView];
        [self addSubview:middleView];
        _middleView = middleView;
    }
    return _middleView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpInit];
    }
    return self;
}
- (void)setUpInit{
//    设置样式，去除tabbar上面的黑线
    self.barStyle = UIBarStyleDefault;
    // 设置tabbar 背景图片
//    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
//    NSString *bundleName = [currentBundle.infoDictionary[@"CFBundleName"] stringByAppendingString:@".bundle"];
//    NSString *path = [currentBundle pathForResource:@"tabbar_bg@2x.png" ofType:nil inDirectory:bundleName];
//
//    UIImage *image = [UIImage imageWithContentsOfFile:path];
//    UIImage * image = [UIImage originImageWithName:@"tabbar_bg"];
//    self.backgroundImage = image;
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat  width = 65;
    CGFloat height = 65;
    self.middleView.frame = CGRectMake((WAIScreenWidth - width) * 0.5, (WAIScreenHeight - height) * 0.5, width, height);
}

-(void)setMiddleDidClick:(void (^)(BOOL))middleDidClick{
    self.middleView.middleClickBlock = middleDidClick;
}
-(void)layoutSubviews{
    [super layoutSubviews];
//    遍历所有子控件
    NSUInteger count = self.items.count;
    NSArray * subviews = self.subviews;
    CGFloat btnW = self.width / (count + 1);
    CGFloat btnH = 49;
    CGFloat btnY = 0;
    
    NSInteger index = 0;
    
    for (UIView * subView in subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (index == count / 2) {
                index++;
            }
            CGFloat btnX = index * btnW;
            subView.frame = CGRectMake(btnX, btnY, btnW, btnH);
//            subView.backgroundColor = WAIRandomColor;
//            NSLog(@"%@",NSStringFromCGRect(subView.frame));
            index++;
        }
    }
    
    self.middleView.centerX = self.width * 0.5;
    self.middleView.y = btnH - self.middleView.height ;
//    NSLog(@"%f",self.height);
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//    设置允许交互的区域
//    1、转换点击在tabbar上的坐标，到中间按钮上
    CGPoint pointInMiddleBtn = [self convertPoint:point toView:self.middleView];
//    确定中间按钮的圆心
    CGPoint middleBtnCenter = CGPointMake(33, 33);
//    计算点击的位置距离圆心的距离
    CGFloat distance = sqrt(pow(pointInMiddleBtn.x - middleBtnCenter.x, 2) + pow(pointInMiddleBtn.y - middleBtnCenter.y, 2));
    if (distance > 33 && pointInMiddleBtn.y < 18) {
        return NO;
    }
    return YES;
    
}
@end
