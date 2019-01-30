//
//  WAIDownLoadDataTool.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/29.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAIDownLoadDataTool.h"
#import "WAISessionManager.h"
#import "WAIDownloadService.h"
#import "MJExtension.h"
#import "Sington.h"

@interface WAIDownLoadDataTool()

@property (nonatomic,strong) WAISessionManager * sessionMgr;

@end

@implementation WAIDownLoadDataTool

singtonImplement(WAIDownLoadDataTool)

-(WAISessionManager *)sessionMgr{
    if (!_sessionMgr) {
        _sessionMgr = [[WAISessionManager alloc]init];
    }
    return _sessionMgr;
}
-(void)getTodayFireShareAndCategoryData:(void (^)(WAIShareModel * _Nonnull, NSArray<WAICategoryModel *> * _Nonnull))result{
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/rankingList/track"];
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"key": @"ranking:track:scoreByTime:1:0",
                            @"pageId": @"1",
                            @"pageSize": @"0"
                            };
    [self.sessionMgr request:WAIRequestMethodGET methodURL:url parameters:param resultBlock:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        WAIShareModel * shareM = [WAIShareModel mj_objectWithKeyValues:responseObject[@"shareContent"]];
        
       WAICategoryModel *categoryM = [[WAICategoryModel alloc] init];
        categoryM.key = @"ranking:track:scoreByTime:1:0";
        categoryM.name = @"总榜";
        NSMutableArray <WAICategoryModel *>* categoryMs = [WAICategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"categories"]];
        [categoryMs insertObject:categoryM atIndex:0];
        
        result(shareM,categoryMs);
    }];
}

- (void)getVoiceMsWithKey:(NSString *)key pageNum:(NSInteger)page result:(void (^)(NSArray<WAIDownLoadVoiceModel *> * _Nonnull))result{
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/rankingList/track"];
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"key": key,
                            @"pageId": @"1",
                            @"pageSize": @"30"
                            };
    [self.sessionMgr request:WAIRequestMethodGET methodURL:url parameters:param resultBlock:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        NSMutableArray <WAIDownLoadVoiceModel *> * voiceyMs = [WAIDownLoadVoiceModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        result(voiceyMs);
    }];
}
@end
