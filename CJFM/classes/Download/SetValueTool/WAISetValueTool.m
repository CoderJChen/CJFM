//
//  WAISetValueTool.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/30.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAISetValueTool.h"
#import "WAIDownLoadVoiceModel.h"
#import "WAITodayFireVoiceCell.h"

@implementation WAISetValueTool
+(id)setModel:(id)model toCell:(UITableViewCell *)cell{
    if ([model isKindOfClass:[WAIDownLoadVoiceModel class]]) {
        WAIDownLoadVoiceModel * modelR = (WAIDownLoadVoiceModel *)model;
        if ([cell isKindOfClass:[WAITodayFireVoiceCell class]]) {
            WAITodayFireVoiceCell * cellR = (WAITodayFireVoiceCell *)cell;
            cellR.voiceTitleLabel.text = modelR.title;
            cellR.voiceAuthorLabel.text = [NSString stringWithFormat:@"by %@",modelR.nickname];
//            [cellR.playOrPauseBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:modelR.coverSmall]  forState:UIControlStateNormal];
            cellR.sortNumLabel.text = [NSString stringWithFormat:@"%zd", modelR.sortNum];

            cellR.downLoadState = WAICellDownLoadStateWait;
            cellR.clickBlock = modelR.clickBlock;
            
            cellR.trackID = modelR.trackId;
            
        }
    }
    return nil;
}
@end
