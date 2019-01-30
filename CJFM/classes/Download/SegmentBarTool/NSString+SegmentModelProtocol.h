//
//  NSString+SegmentModelProtocol.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/28.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAISegmentModelProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSString (SegmentModelProtocol)<WAISegmentModelProtocol>
/**选项卡的ID，如果不设置， 默认从0开始*/
-(NSInteger)segID;
/**
 设置选项卡内容
 */
-(NSString *)segContent;
@end

NS_ASSUME_NONNULL_END
