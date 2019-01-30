//
//  WAISessionManager.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/29.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WAIRequestMethod) {
    WAIRequestMethodGET,
    WAIRequestMethodPOST
};

NS_ASSUME_NONNULL_BEGIN

@interface WAISessionManager : NSObject

- (void)setValue:(NSString *)value forHttpField:(NSString *)field;

- (void)request:(WAIRequestMethod)requestType methodURL:(NSString *)url parameters:(NSDictionary *)params resultBlock:(void(^)(id responseObject,NSError * error))resultBlock;
@end

NS_ASSUME_NONNULL_END
