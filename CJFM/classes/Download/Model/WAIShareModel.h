//
//  WAIShareModel.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/29.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAIShareModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger lengthLimit;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *rowKey;
@property (nonatomic, copy) NSString *shareType;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *weixinPic;
@end

NS_ASSUME_NONNULL_END
