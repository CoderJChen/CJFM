//
//  WAIDownLoader.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/25.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAIDownLoader.h"
#import "WAIFileTool.h"

#define WAICachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
#define WAITmpPath NSTemporaryDirectory()

#define WAIHeaderFilePath @"headerMsg.plist"

@interface WAIDownLoader()<NSURLSessionDataDelegate>
{
    long long _tmpSize;
    long long _totalSize;
}

/**
 文件名称
 */
@property(copy,nonatomic) NSString * fileFullPath;

/**
 w存储文件总大小
 */
@property(assign,nonatomic)long long int  fileTotalSize;

/**
 当前文件已经下载大小
 */
@property(assign,nonatomic) long long int fileCurrentSize;

/**下载完成路径*/
@property(copy,nonatomic) NSString * downloadedPath;
/**下载中路径*/
@property(copy,nonatomic) NSString * downloadingPath;
/**下载会话*/
@property (nonatomic,weak) NSURLSession * session;
/**文件输出流*/
@property (nonatomic,strong) NSOutputStream * outPutStream;

/**
 下载任务
 */
@property (nonatomic,strong) NSURLSessionDataTask * downloadTask;

/**
 下载进度条
 */
@property(copy,nonatomic)void(^progressBlock)(float progress);

/**
 下载成功block
 */
@property(copy,nonatomic)void(^successBlock)(NSString * downloadPath);

/**
 下载失败block
 */
@property(copy,nonatomic)void(^failBlock)(void);

@end

@implementation WAIDownLoader
-(NSURLSession *)session{
    if (!_session) {
        NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession * ssion = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        _session = ssion;
    }
    return _session;
}

-(void)downloadWithURL:(NSURL *)url withProgressBlock:(void (^)(float))progressBlock success:(void (^)(NSString * _Nonnull))successBlock andError:(void (^)(void))failedBlock{
    self.downloadURL = url;
    self.progressBlock = progressBlock;
    self.successBlock = successBlock;
    self.failBlock = failedBlock;
    
    if (self.isDownloading) {
        NSLog(@"正在下载");
        return;
    }
    
    BOOL result = [self getRemoteFileMessage];
    if (!result) {
        NSLog(@"下载出错，请重新尝试");
        self.failBlock();
        _isDownloading = NO;
        return;
    }
    
    BOOL isRequireDownload = [self checkLocalFile];
    if (isRequireDownload) {
        NSLog(@"根据文件缓冲大小，执行操作");
        [self startDownload];
    }else{
        NSLog(@"文件已经存在");
        self.successBlock(self.fileFullPath);
    }
    
}

/**
 检测文件是否需要下载

 @return YES==NO  需要下载==>不需要下载
 */
- (BOOL)checkLocalFile{
    self.fileCurrentSize = [WAIFileTool fileSize:self.fileFullPath];
    if (self.fileCurrentSize > self.fileTotalSize) {
//        删除文件，重新下载
        [WAIFileTool removeFile:self.fileFullPath];
        return YES;
    }
    if (self.fileCurrentSize < self.fileTotalSize) {
        return YES;
    }
    return NO;
}

/**
 检测远程文件信息，获取远程文件路径and文件大小

 @return YES  本地或者远程获取文件信息，否则获取失败
 */
- (BOOL)getRemoteFileMessage{
    NSString * headMsgPath  = [WAITmpPath stringByAppendingPathComponent:WAIHeaderFilePath];
    NSString * fileName = self.downloadURL.lastPathComponent;
    NSMutableDictionary * tmpDict = [NSMutableDictionary dictionaryWithContentsOfFile:headMsgPath];
    if (tmpDict == nil) {
        tmpDict = [NSMutableDictionary dictionary];
    }
    if ([tmpDict.allKeys containsObject:fileName]) {
        self.fileFullPath = [WAITmpPath stringByAppendingPathComponent:fileName];
        self.fileTotalSize = [tmpDict[fileName] longLongValue];
        return YES;
    }
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:self.downloadURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.0];
    request.HTTPMethod = @"HEAD";
    NSURLResponse * response = nil;
    NSError * error = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error == nil) {
        self.fileTotalSize = response.expectedContentLength;
        self.fileFullPath = [WAITmpPath stringByAppendingPathComponent:response.suggestedFilename];
        [tmpDict setValue:@(response.expectedContentLength) forKey:fileName];
        [tmpDict writeToFile:headMsgPath atomically:YES];
        return YES;
    }
    
    return NO;
}

/**
 开始下载任务
 */
- (void)startDownload{
    _isDownloading = YES;
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:self.downloadURL];
    [request setValue:[NSString stringWithFormat:@"bytes=%lld-",self.fileCurrentSize] forHTTPHeaderField:@"Range"];
    self.downloadTask = [self.session dataTaskWithRequest:request];
    [self.downloadTask resume];
    
    NSLog(@"download -----%zd",self.downloadTask.state);
}

/**
 获取文件大小

 @param url 当前文件URL
 @return 返回文件大小
 */
+(long long int)cacheFileSizeWithURL:(NSURL *)url{
    NSString * path = [WAITmpPath stringByAppendingPathComponent:url.lastPathComponent];
    return [WAIFileTool fileSize:path];
}

/**
 删除文件

 @param url 根据当前URL删除该文件
 */
+(void)removeCacheFileWithURL:(NSURL *)url{
    NSString * path = [WAITmpPath stringByAppendingPathComponent:url.lastPathComponent];
    [WAIFileTool removeFile:path];
}
-(void)setDownloadURL:(NSURL * _Nonnull)downloadURL{
    _downloadURL = downloadURL;
}
-(void)setProgress:(float)progress{
    _progress = progress;
}
#pragma mark -私有方法
- (void)downloadWithUrl:(NSURL *)url andOffset:(long long)offSet{
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0];
    
    [request setValue:[NSString stringWithFormat:@"bytes=%lld-",offSet] forHTTPHeaderField:@"Range"];
    self.downloadTask = [self.session dataTaskWithRequest:request];
    
    [self.downloadTask resume];
}

/**
 继续当前任务
 */
- (void)resumeCurrentTask{
    self.isDownloading = YES;
    if (self.downloadTask) {
        [self.downloadTask resume];
    }else{
        [self downloadWithURL:self.downloadURL withProgressBlock:self.progressBlock success:self.successBlock andError:self.failBlock];
    }
    NSLog(@"继续：download -----%zd",self.downloadTask.state);
}

/**
 暂停任务
 注意：
 如果调用几次继续
 调用几次暂停，才可以暂停
 解决方案：引入状态
 */
- (void)pauseCurrentTask{
    
    self.isDownloading = NO;
    [self.downloadTask suspend];
    NSLog(@"暂停：download -----%zd",self.downloadTask.state);
}

/**
 取消任务
 */
- (void)cancelCurrentTask{
    self.isDownloading = NO;
    [self.session invalidateAndCancel];
    [self.downloadTask cancel];
    self.session = nil;
    self.downloadTask = nil;
    
    NSLog(@"取消：download -----%zd",self.downloadTask.state);
}

/**
 取消任务，并清除资源
 */
- (void)cancelAndClean{
    [self cancelCurrentTask];
    [WAIFileTool removeFile:self.downloadingPath];
}



#pragma mark - NSUrlSessionDataDelegate
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    
    self.outPutStream = [NSOutputStream outputStreamToFileAtPath:self.fileFullPath append:YES];
    [self.outPutStream open];
//    继续接受数据
    completionHandler(NSURLSessionResponseAllow);
}
//当用户确定，继续接受数据的时候调用
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    
    [self.outPutStream write:data.bytes maxLength:data.length];
    
    self.fileCurrentSize += data.length;
    
    _progress = 1.0 * self.fileCurrentSize / self.fileTotalSize;
    if (self.progressBlock) {
        self.progressBlock(_progress);
    }
}
//请求完成的时候调用
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSLog(@"didCompleteWithError == %@",error.localizedDescription);
//    if (error == nil) {
//        [WAIFileTool moveFile:self.downloadingPath andToPath:self.downloadedPath];
//    }else{
//        NSLog(@"下载有问题");
//    }
    [self.outPutStream close];
    self.outPutStream = nil;
    if (error == nil) {
        self.successBlock(self.fileFullPath);
    }else{
        self.failBlock();
    }
}


@end
