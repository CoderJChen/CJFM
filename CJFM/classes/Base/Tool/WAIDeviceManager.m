//
//  WAIDeviceManager.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/29.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAIDeviceManager.h"
#import <sys/param.h>
#import <sys/mount.h>

@implementation WAIDeviceManager

+(NSString *)freeDiskSpacebytes{
    struct statfs buf;
    float freeSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        freeSpace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    NSArray * units = @[@"B",@"KB",@"MB",@"GB",@"TB"];
    NSUInteger count = 1000;
    NSInteger index = 0;
    while (freeSpace > count) {
        freeSpace = freeSpace / count;
        index ++;
    }
    NSString * formatString = [NSString stringWithFormat:@"%.1f%@",freeSpace,units[index]];
    return formatString;
}
@end
