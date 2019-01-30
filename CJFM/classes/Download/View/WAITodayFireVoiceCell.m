//
//  WAITodayFireVoiceCell.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/30.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAITodayFireVoiceCell.h"
#import "WAIDownLoadDataTool.h"
#import "WAIDownLoadAPIDefine.h"

@implementation WAITodayFireVoiceCell
static NSString *const cellID = @"todayFireVoice";

+(instancetype)cellWithTableView:(UITableView *)tableView{
    WAITodayFireVoiceCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [self WAI_ViewFromXib];
        [cell addObserver:cell forKeyPath:@"sortNumLabel.text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return cell;
}
- (IBAction)downLoad {
    if (self.clickBlock && self.downLoadState == WAICellDownLoadStateWait) {
        self.clickBlock();
        self.downLoadState = WAICellDownLoadStateDownLoaded;
    }
}
- (IBAction)playOrPause:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playImage" object:[sender backgroundImageForState:UIControlStateNormal]];
    
    if (sender.selected) {
        
    }else{
        
    }
}

-(void)setDownLoadState:(WAICellDownLoadState)downLoadState{
    _downLoadState = downLoadState;
    if (downLoadState == WAICellDownLoadStateWait) {
        [self.downLoadBtn.imageView.layer removeAllAnimations];
        [self.downLoadBtn setImage:[UIImage imageNamed:@"cell_download"] forState:UIControlStateNormal];
    }else if (downLoadState == WAICellDownLoadStateDownLoading){

        [self.downLoadBtn setImage:[UIImage imageNamed:@"cell_download_loading"] forState:UIControlStateNormal];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = @(0);
        animation.toValue = @(M_PI * 2.0);
        animation.duration = 10;
        [self.downLoadBtn.imageView.layer addAnimation:animation forKey:@"rotation"];
    }else if (downLoadState == WAICellDownLoadStateDownLoaded){
        [self.downLoadBtn.imageView.layer removeAllAnimations];
        [self.downLoadBtn setImage:[UIImage imageNamed:@"cell_downloaded"] forState:UIControlStateNormal];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.playOrPauseBtn.layer.masksToBounds = YES;
    self.playOrPauseBtn.layer.borderWidth = 3;
    self.playOrPauseBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playStateChange:) name:@"playStatus" object:nil];
}

- (void)playStateChange:(NSNotification *)notification{
    BOOL isPlaying = [notification.object boolValue];
    if ([WAIDownLoadDataTool shareInstance].currentTrackID == self.trackID) {
        self.playOrPauseBtn.selected = isPlaying;
    }else{
        self.playOrPauseBtn.selected = NO;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.playOrPauseBtn.layer.cornerRadius = self.playOrPauseBtn.width * 0.5;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)dealloc{
    [self removeObserver:self forKeyPath:@"sortNumLabel.text"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"sortNumLabel.text"]) {
        NSInteger sort = [change[@"new"] integerValue];
        if (sort == 1) {
            self.sortNumLabel.textColor = [UIColor redColor];
        }else if (sort == 2) {
            self.sortNumLabel.textColor = [UIColor orangeColor];
        }else if (sort == 3) {
            self.sortNumLabel.textColor = [UIColor greenColor];
        }else {
            self.sortNumLabel.textColor = [UIColor grayColor];
        }
        
        return;
    }
    
}

@end
