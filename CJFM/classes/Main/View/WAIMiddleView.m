//
//  WAIMiddleView.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/24.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAIMiddleView.h"
#import "CALayer+WAIPauseAnimate.h"

@interface WAIMiddleView()
/**
 中间的播放内容视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;

/**
 播放按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@end

@implementation WAIMiddleView

static WAIMiddleView * _instance;

+ (instancetype)shareInstance{
    if (!_instance) {
        _instance = [WAIMiddleView middleView];
    }
    return _instance;
}

+(instancetype)middleView{
    NSBundle * currentBundle = [NSBundle bundleForClass:self];
    WAIMiddleView * middleView = [currentBundle loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    return middleView;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.middleImageView.layer.masksToBounds = YES;
    self.middleImg = self.middleImageView.image;
    
    [self.middleImageView.layer removeAnimationForKey:@"playAnimation"];
    CABasicAnimation * basicAnimation = [[CABasicAnimation alloc]init];
    basicAnimation.keyPath = @"transform.rotation.z";
    basicAnimation.fromValue = @(0);
    basicAnimation.toValue = @(M_PI * 2);
    basicAnimation.duration = 30;
    basicAnimation.repeatCount = MAXFLOAT;
    basicAnimation.removedOnCompletion = NO;
    [self.middleImageView.layer addAnimation:basicAnimation forKey:@"playAnimation"];
    [self.middleImageView.layer pauseAnimate];
    
    [self.playBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(isPlayerPlay:) name:@"playStatus" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setPlayImage:) name:@"playImage" object:nil];
    
}
- (void)isPlayerPlay:(NSNotification *)notication{
    BOOL isPlay = [notication.object boolValue];
    self.isPlaying = isPlay;
}
- (void)setPlayImage:(NSNotification *)notification{
    UIImage * image = notification.object;
    self.middleImg = image;
}
- (void)btnClick:(UIButton *)btn{
    if (self.middleClickBlock) {
        self.middleClickBlock(self.isPlaying);
    }
}
-(void)setIsPlaying:(BOOL)isPlaying{
    if (_isPlaying == isPlaying) {
        return;
    }
    _isPlaying = isPlaying;
    if (isPlaying) {
        [self.playBtn setImage:nil forState:UIControlStateNormal];
        [self.middleImageView.layer resumeAnimate];
    }else{
        UIImage *image = [UIImage imageNamed:@"tabbar_np_play"];
        [self.playBtn setImage:image forState:UIControlStateNormal];
        
        [self.middleImageView.layer pauseAnimate];
    }
}
- (void)setMiddleImg:(UIImage *)middleImg{
    _middleImg = middleImg;
    self.middleImageView.image = middleImg;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.middleImageView.layer.cornerRadius = self.middleImageView.width * 0.5;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
