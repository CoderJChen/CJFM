//
//  WAIDownLoadAPIDefine.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/30.
//  Copyright © 2019 Eric. All rights reserved.
//

// 1. 加载专辑信息
#define WAILoadTrackInfo(trackID) \
[[NSNotificationCenter defaultCenter] \
postNotificationName:@"DownLoadListern_loadTrackInfo" object:trackID];

// 2. 跳转到播放器的通知定义
#define WAIPresentToPlayer(trackID) \
[[NSNotificationCenter defaultCenter]  \
postNotificationName:@"DownLoadListern_presentPlayer" \
object:trackID];
