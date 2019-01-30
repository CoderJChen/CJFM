//
//  WAISegmentBar.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/26.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WAISegmentBarConfig.h"
#import "NSString+SegmentModelProtocol.h"

@class WAISegmentBar;
NS_ASSUME_NONNULL_BEGIN

@protocol WAISegmentBarDelegate <NSObject>
@optional
- (void)segmentBar:(WAISegmentBar *)segmentBar didSelectedWithIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex;
@end

@interface WAISegmentBar : UIView

@property (nonatomic,strong) NSArray <NSString *>* items;

/** 选项卡模型数组, 此处传递字符串数组也可以, 只不过索引变成了对应的数组下标 */
@property (nonatomic, strong) NSArray <id<WAISegmentModelProtocol>>*segmentMs;

@property (nonatomic,weak) id <WAISegmentBarDelegate> delegate;

@property(assign,nonatomic) NSInteger  selectIndex;


+ (instancetype)segmentBarWithFrame:(CGRect)frame;

+ (instancetype)segmentBarWithConfig:(WAISegmentBarConfig *)config;

- (void)updateWithConfig:(void(^)(WAISegmentBarConfig * config)) configBlock;




@end

NS_ASSUME_NONNULL_END
