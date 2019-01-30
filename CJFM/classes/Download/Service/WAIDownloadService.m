//
//  WAIDownloadService.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/29.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAIDownloadService.h"
#import "Sington.h"

@implementation WAIDownloadService
singtonImplement(WAIDownloadService);

+ (void)downLoadVoiceM:(WAIDownLoadVoiceModel *)downLoadVoiceM{
    
}
+(void)pauseVoiceM:(WAIDownLoadVoiceModel *)downLoadVoiceM{
    
}
+(void)stopVoiceM:(WAIDownLoadVoiceModel *)downLoadVoiceM{
    
}
+(BOOL)isExsists:(NSString *)filePath{
    return YES;
}
@end
