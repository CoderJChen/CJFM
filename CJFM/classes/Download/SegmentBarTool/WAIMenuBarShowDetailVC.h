//
//  WAIMenuBarShowDetailVC.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/28.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+SegmentModelProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface WAIMenuBarShowDetailVC : UICollectionViewController

@property(assign,nonatomic) CGFloat  expectedHeight;
@property (nonatomic,strong) NSArray <id <WAISegmentModelProtocol>> * items;

@end

NS_ASSUME_NONNULL_END
