//
//  WAISegmentBarConfig.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/26.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAISegmentBarConfig.h"

@implementation WAISegmentBarConfig
+(instancetype)defaultConfig{
    WAISegmentBarConfig * config = [[WAISegmentBarConfig alloc]init];
    config.segmentBarBackColor = [UIColor clearColor];
    config.itemNormalFont = [UIFont systemFontOfSize:12];
    config.itemSelectFont = [UIFont systemFontOfSize:12];
    config.itemNormalColor = [UIColor grayColor];
    config.itemSelectColor = [UIColor redColor];
    
    config.indicatorColor = [UIColor redColor];
    config.indicatorHeight = 2;
    config.indicatorExtraW = 10;
    
    return config;
}

- (UIColor *)segmentBarBackColor{
    if (!_segmentBarBackColor) {
        _segmentBarBackColor = [UIColor clearColor];
    }
    return _segmentBarBackColor;
}
-(WAISegmentBarConfig * _Nonnull (^)(UIFont * _Nonnull))itemNF{
    return ^(UIFont * font){
        self.itemNormalFont = font;
        return self;
    };
}
- (WAISegmentBarConfig * _Nonnull (^)(UIFont * _Nonnull))itemSF{
    return ^(UIFont * font){
        self.itemSelectFont = font;
        return self;
    };
}
-(WAISegmentBarConfig * _Nonnull (^)(UIColor * _Nonnull))itemNC{
    return ^(UIColor * color){
        self.itemNormalColor = color;
        return self;
    };
}
-(WAISegmentBarConfig * _Nonnull (^)(UIColor * _Nonnull))itemSC{
    return ^(UIColor * color){
        self.itemSelectColor = color;
        return self;
    };
}
- (WAISegmentBarConfig * _Nonnull (^)(CGFloat))indicatorEW{
    return ^(CGFloat indicatorEW){
        self.indicatorExtraW = indicatorEW;
        return self;
    };
}
/** 选项卡之间的最小间距 */
- (CGFloat)limitMargin {
    if (_limitMargin <= 0) {
        _limitMargin = 25;
    }
    
    return _limitMargin;
}

@end
