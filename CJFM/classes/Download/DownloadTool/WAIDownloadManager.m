//
//  WAIDownloadManager.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/26.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAIDownloadManager.h"
#import "WAIDownLoader.h"

@interface WAIDownloadManager()
@property (nonatomic,strong) NSMutableDictionary * downloadDict;
@end
@implementation WAIDownloadManager

static WAIDownloadManager * _instance;
+(instancetype)shareInstance{
    if (!_instance) {
        _instance = [[WAIDownloadManager alloc]init];
    }
    return _instance;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
-(NSMutableDictionary *)downloadDict{
    if (!_downloadDict) {
        _downloadDict = [NSMutableDictionary dictionary];
    }
    return _downloadDict;
}

/**
 根据URL地址下载资源，如果任务已经存在，则执行继续动作
 
 @param url 资源路径
 @return 获取下载器对象
 */
- (WAIDownLoader *)loaderWithURL:(NSURL *)url{
    return self.downloadDict[url.lastPathComponent];
}
/**
 根据URL地址下载资源，如果任务已经存在，则执行继续动作
 
 @param url 资源路径
 @param progressBlock 下载进度
 @param successBlock 成功回调
 @param failedBlock 失败回调
 */
-(void)downloadWithURL:(NSURL *)url withProgressBlock:(void (^)(float))progressBlock success:(void (^)(NSString * _Nonnull))successBlock andError:(void (^)(void))failedBlock{
    WAIDownLoader * downloader = [self loaderWithURL:url];
    __weak WAIDownloadManager * weakManager = self;
    if (!downloader) {
        downloader = [[WAIDownLoader alloc]init];
        [self.downloadDict setValue:downloader forKey:url.lastPathComponent];
        [downloader downloadWithURL:url withProgressBlock:^(float progress) {
            progressBlock(progress);
        } success:^(NSString * _Nonnull downloadPath) {
            successBlock(downloadPath);
//            移除对象
            [weakManager.downloadDict removeObjectForKey:downloadPath.lastPathComponent];
        } andError:^{
            failedBlock();
        }];
    }else{
        [downloader resumeCurrentTask];
    }
}

/**
 暂停下载
 
 @param url 暂停下载路径
 */
- (void)pauseDownLoadWithURL:(NSURL *)url{
    WAIDownLoader * downloader = [self loaderWithURL:url];
    [downloader pauseCurrentTask];
}

/**
 继续开始下载
 
 @param url 继续开始路径
 */
- (void)resumeDownLoadWithURL:(NSURL *)url{
    WAIDownLoader * downloader = [self loaderWithURL:url];
    [downloader resumeCurrentTask];
}

/**
 取消下载
 
 @param url 取消下载路径
 */
- (void)cancelDownLoadWithURL:(NSURL *)url{
    WAIDownLoader * downloader = [self loaderWithURL:url];
    if (downloader) {
        [downloader cancelAndClean];
    }else{
        [WAIDownLoader removeCacheFileWithURL:url];
    }
}
@end
