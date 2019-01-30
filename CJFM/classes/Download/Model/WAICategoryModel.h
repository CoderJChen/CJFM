//
//  WAICategoryModel.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/29.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAICategoryModel : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *name;
@end

NS_ASSUME_NONNULL_END
