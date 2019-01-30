//
//  WAIFileTool.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/25.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAIFileTool.h"

@implementation WAIFileTool
+(BOOL)fileExists:(NSString *)filePath{
    if (filePath.length == 0) {
        return NO;
    }
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}
+(long long)fileSize:(NSString *)filePath{
    if (![self fileExists:filePath]) {
        return 0;
    }
    NSDictionary * fileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    return [fileInfo[NSFileSize] longLongValue];
}

+(void)moveFile:(NSString *)fromPath andToPath:(NSString *)toPath{
    if (![self fileExists:fromPath]) {
        return;
    }
    [[NSFileManager defaultManager] moveItemAtPath:fromPath toPath:toPath error:nil];
}
+(void)removeFile:(NSString *)filePath{
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

+(NSString *)getSizeWithPath:(NSString *)path{
    NSFileManager * mgr = [NSFileManager defaultManager];
    float totalSize = 0;
    BOOL isDirectory = NO;
    if (![mgr fileExistsAtPath:path isDirectory:&isDirectory]) {
        return @"";
    }else if (!isDirectory){
        totalSize = [mgr attributesOfItemAtPath:path error:nil].fileSize;
    }else{
        NSArray * subPaths = [mgr subpathsAtPath:path];
        for (NSString * subPath in subPaths) {
            NSDictionary * pathDict = [mgr attributesOfItemAtPath:[path stringByAppendingPathComponent:subPath] error:nil];
            if (pathDict.fileType == NSFileTypeRegular) {
                totalSize += pathDict.fileSize;
            }
        }
    }
    NSArray * units = @[@"B",@"KB",@"MB",@"GB",@"TB"];
    NSUInteger count = 1000;
    NSInteger index = 0;
    while (totalSize > count) {
        totalSize = totalSize / count;
        index ++;
    }
    NSString * formatString = [NSString stringWithFormat:@"%.1f%@",totalSize,units[index]];
    return formatString;
}
+(void)clearCacheWithPath:(NSString *)path{
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:path error:nil];
}
+ (NSString *)calculateUnit:(unsigned long long)contentLength{
    if (contentLength >= pow(1024, 3)) {
        return @"GB";
    }else if (contentLength >= pow(1024, 2)){
        return @"MB";
    }else if (contentLength >= 1024){
        return @"KB";
    }else{
        return @"Bytes";
    }
}
+(float)calculateFileSizeUnit:(unsigned long long)contentLength{
    if (contentLength >= pow(1024, 3)) {
        return (float)(contentLength / (float)pow(1024, 3));
    }else if(contentLength >= pow(1024, 2)){
        return (float)(contentLength / (float)pow(1024, 2));
    }else if (contentLength >= 1024){
        return (float)(contentLength / (float)1024);
    }else{
        return (float)contentLength;
    }
}
@end
