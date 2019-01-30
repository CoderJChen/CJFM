//
//  UIImage+WAIImage.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/24.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "UIImage+WAIImage.h"

@implementation UIImage (WAIImage)
+ (UIImage *)originImageWithName:(NSString *)originName{
    return [[UIImage imageNamed:originName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
-(UIImage *)circleImage{
    CGSize size = self.size;
    CGFloat drawWH = size.width >= size.height ? size.height : size.width;
    
//    l、开启图形上下文
    UIGraphicsBeginImageContext(CGSizeMake(drawWH, drawWH));
//    2、绘制一个圆形区域，进行裁剪
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, drawWH, drawWH));
    CGContextClip(context);
//    绘制大图片
    CGRect drawRect = CGRectMake(0, 0, size.width, size.height);
    [self drawInRect:drawRect];
//    去除结果图片
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
//    结束图形上下文
    UIGraphicsEndImageContext();
    
    return resultImage;
}
@end
