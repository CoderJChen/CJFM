//
//  WAISessionManager.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/29.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAISessionManager.h"
#import "AFNetworking.h"

@interface WAISessionManager()
@property (nonatomic,strong) AFHTTPSessionManager * sessionMgr;
@end
@implementation WAISessionManager
-(AFHTTPSessionManager *)sessionMgr{
    if (!_sessionMgr) {
        _sessionMgr = [AFHTTPSessionManager manager];
        NSMutableSet * setM = [_sessionMgr.responseSerializer.acceptableContentTypes mutableCopy];
        [setM addObject:@"text/plain"];
        [setM addObject:@"text/html"];
        _sessionMgr.responseSerializer.acceptableContentTypes = [setM copy];
    }
    return _sessionMgr;
}
-(void)setValue:(NSString *)value forHttpField:(NSString *)field{
    [self.sessionMgr.requestSerializer setValue:value forHTTPHeaderField:field];
}
-(void)request:(WAIRequestMethod)requestType methodURL:(NSString *)url parameters:(NSDictionary *)params resultBlock:(void (^)(id responseObject, NSError * error))resultBlock{
    void(^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        resultBlock(responseObject,nil);
    };
   void(^failedBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       resultBlock(nil,error);
    };
    
    if (requestType == WAIRequestMethodGET) {
        [self.sessionMgr GET:url parameters:params progress:nil success:successBlock failure:failedBlock];
    }else if (requestType == WAIRequestMethodPOST){
        [self.sessionMgr POST:url parameters:params progress:nil success:successBlock failure:failedBlock];
    }
}
@end
