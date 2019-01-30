//
//  WAIFileTool.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/25.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAIFileTool : NSObject

/**
 检测文件是否存在

 @param filePath 文件路径
 @return 返回判断值
 */
+ (BOOL)fileExists:(NSString *)filePath;

/**
 获取文件路径所在文件的大小

 @param filePath 文件路径对应的文件
 @return 返回文件大小
 */
+ (long long)fileSize:(NSString *)filePath;

/**
 移动文件

 @param fromPath 目标文件路径
 @param toPath 目的文件路径
 */
+ (void)moveFile:(NSString *)fromPath andToPath:(NSString *)toPath;

/**
 移除文件

 @param filePath 移除文件路径所在文件
 */
+ (void)removeFile:(NSString *)filePath;

/**
 计算文件大小值

 @param contentLength 文件大小
 @return 返回文件大小
 */
+ (float)calculateFileSizeUnit:(unsigned long long)contentLength;

/**
 计算文件大小对应长度单位

 @param contentLength 文件长度
 @return 获取文件所对应的长度单位
 */
+ (NSString *)calculateUnit:(unsigned long long)contentLength;

+ (NSString *)getSizeWithPath: (NSString *)path;

+ (void)clearCacheWithPath: (NSString *)path;

@end

NS_ASSUME_NONNULL_END
