//
//  WAIDownLoadDataTool.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/29.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAIShareModel.h"
#import "WAICategoryModel.h"
#import "WAIDownLoadVoiceModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface WAIDownLoadDataTool : NSObject
+ (instancetype)shareInstance;

/**
 当前正在播放的ID
 */
@property (nonatomic, assign) NSInteger currentTrackID;

/**
 *  获取今日最火, 分享内容, 和分类列表
 *
 *  @param result 分享内容, 分类列表
 */
- (void)getTodayFireShareAndCategoryData:(void(^)(WAIShareModel *shareM, NSArray <WAICategoryModel *>*categoryMs))result;
/**
 *  获取下载声音列表
 *
 *  @param key    类别key
 *  @param page   页数
 *  @param result 下载的声音模型数组
 */
- (void)getVoiceMsWithKey:(NSString *)key pageNum:(NSInteger)page result:(void(^)(NSArray <WAIDownLoadVoiceModel *>*voiceMs))result;
@end

NS_ASSUME_NONNULL_END
