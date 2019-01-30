//
//  WAIDeviceManager.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/29.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAIDeviceManager : NSObject

/**
 设备剩余d存储空间

 @return 剩余存储空间
 */
+ (NSString *)freeDiskSpacebytes;
@end

NS_ASSUME_NONNULL_END
