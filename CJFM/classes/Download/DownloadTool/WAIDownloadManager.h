//
//  WAIDownloadManager.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/26.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WAIDownLoader;
NS_ASSUME_NONNULL_BEGIN

@interface WAIDownloadManager : NSObject

/**
 单例获取下载器

 @return 返回下载器对象
 */
+ (instancetype)shareInstance;


/**
 根据URL地址下载资源，如果任务已经存在，则执行继续动作

 @param url 资源路径
 @return 获取下载器对象
 */
- (WAIDownLoader *)loaderWithURL:(NSURL *)url;
/**
 根据URL地址下载资源，如果任务已经存在，则执行继续动作
 
 @param url 资源路径
 @param progressBlock 下载进度
 @param successBlock 成功回调
 @param failedBlock 失败回调
 */
- (void)downloadWithURL:(NSURL *)url withProgressBlock:(void(^)(float progress))progressBlock success:(void(^)(NSString * downloadPath))successBlock andError:(void(^)(void))failedBlock;

/**
 暂停下载

 @param url 暂停下载路径
 */
- (void)pauseDownLoadWithURL:(NSURL *)url;

/**
 继续开始下载

 @param url 继续开始路径
 */
- (void)resumeDownLoadWithURL:(NSURL *)url;

/**
 取消下载

 @param url 取消下载路径
 */
- (void)cancelDownLoadWithURL:(NSURL *)url;
@end

NS_ASSUME_NONNULL_END
