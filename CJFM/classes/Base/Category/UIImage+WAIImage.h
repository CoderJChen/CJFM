//
//  UIImage+WAIImage.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/24.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (WAIImage)

/**
 对图片进行处理

 @param originName 传入的压缩图片
 @return 返回处理后的图片
 */
+ (UIImage *)originImageWithName:(NSString *)originName;

/**
 对图片进行截圆

 @return 返回截圆后的图片
 */
- (UIImage *)circleImage;
@end

NS_ASSUME_NONNULL_END
