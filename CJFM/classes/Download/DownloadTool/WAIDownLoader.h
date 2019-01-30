//
//  WAIDownLoader.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/25.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAIDownLoader : NSObject
/**
 根据URL地址下载资源，如果任务已经存在，则执行继续动作

 @param url 资源路径
 @param progressBlock 下载进度
 @param successBlock 成功回调
 @param failedBlock 失败回调
 */
- (void)downloadWithURL:(NSURL *)url withProgressBlock:(void(^)(float progress))progressBlock success:(void(^)(NSString * downloadPath))successBlock andError:(void(^)(void))failedBlock;
/**
 继续当前任务
 */
- (void)resumeCurrentTask;

/**
 暂停任务
 注意：
 如果调用几次继续
 调用几次暂停，才可以暂停
 解决方案：引入状态
 */
- (void)pauseCurrentTask;

/**
 取消任务
 */
- (void)cancelCurrentTask;

/**
 取消任务，并清除资源
 */
- (void)cancelAndClean;

/**
 下载进度条
 */
@property(assign,nonatomic,readonly) float  progress;

/**
 下载状态
 */
@property(assign,nonatomic) BOOL  isDownloading;

/**
 下载地址
 */
@property (nonatomic,strong,readonly) NSURL * downloadURL;

/**
 获取缓冲区的文件缓存大小

 @param url h缓存路径
 @return w缓存文件大小
 */
+ (long long int)cacheFileSizeWithURL:(NSURL *)url;

/**
 删除缓存区文件

 @param url 缓存区文件路径
 */
+ (void)removeCacheFileWithURL:(NSURL *)url;
@end

NS_ASSUME_NONNULL_END
