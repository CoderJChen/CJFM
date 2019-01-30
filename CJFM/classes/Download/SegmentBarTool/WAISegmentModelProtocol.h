//
//  WAISegmentModelProtocol.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/28.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WAISegmentModelProtocol <NSObject>
/**选项卡的ID，如果不设置， 默认从0开始*/
@property(assign,nonatomic,readonly)NSInteger segID;
/**
 设置选项卡内容
 */
@property(assign,nonatomic,readonly)NSString * segContent;
@end

NS_ASSUME_NONNULL_END
