//
//  WAITodayFireVoiceCell.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/30.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  WAICellDownLoadStateWait,
  WAICellDownLoadStateDownLoading,
  WAICellDownLoadStateDownLoaded
}WAICellDownLoadState;

NS_ASSUME_NONNULL_BEGIN

@interface WAITodayFireVoiceCell : UITableViewCell
/** 声音标题 */
@property (weak, nonatomic) IBOutlet UILabel *voiceTitleLabel;
/** 声音作者 */
@property (weak, nonatomic) IBOutlet UILabel *voiceAuthorLabel;
/** 声音播放暂停按钮 */
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;
/** 声音排名标签 */
@property (weak, nonatomic) IBOutlet UILabel *sortNumLabel;
/** 声音下载按钮 */
@property (weak, nonatomic) IBOutlet UIButton *downLoadBtn;


/** 声音下载block */
@property (nonatomic, strong) void(^clickBlock)(void);

@property (nonatomic, assign) NSInteger trackID;
@property (nonatomic, strong) NSURL *playURL;

@property (nonatomic, assign) WAICellDownLoadState downLoadState;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
