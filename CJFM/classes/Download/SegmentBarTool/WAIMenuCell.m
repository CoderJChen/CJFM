//
//  WAIMenuCell.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/28.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAIMenuCell.h"

@implementation WAIMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor = [UIColor redColor];
    }else {
        self.backgroundColor = [UIColor colorWithRed:160 / 255.0 green:160 / 255.0 blue:160 / 255.0 alpha:0.4];
    }
    
    
}

@end
