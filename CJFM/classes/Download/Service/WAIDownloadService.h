//
//  WAIDownloadService.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/29.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAIDownLoadVoiceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WAIDownloadService : NSObject
+ (instancetype)shareInstance;

/**
 *  根据给定的音频模型, 下载对应的数据
 *
 *  @param downLoadVoiceM 音频数据模型
 */
+ (void)downLoadVoiceM:(WAIDownLoadVoiceModel *)downLoadVoiceM;
/**
 *  根据给定的音频模型, 暂停对应的数据
 *
 *  @param downLoadVoiceM 音频数据模型
 */
+ (void)pauseVoiceM:(WAIDownLoadVoiceModel *)downLoadVoiceM;
/**
 *  根据给定的音频模型, 停止对应的数据
 *
 *  @param downLoadVoiceM 音频数据模型
 */
+ (void)stopVoiceM:(WAIDownLoadVoiceModel *)downLoadVoiceM;


/**
 *  验证, 是否已经下载
 *
 *  @param filePath 文件路径
 *
 *  @return 是否已经下载
 */
+ (BOOL)isExsists:(NSString *)filePath;
@end

NS_ASSUME_NONNULL_END
