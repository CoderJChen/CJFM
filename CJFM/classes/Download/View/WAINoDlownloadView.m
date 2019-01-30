//
//  WAINoDlownloadView.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/29.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAINoDlownloadView.h"

@interface WAINoDlownloadView()
@property (weak, nonatomic) IBOutlet UIImageView *noDataImageView;
@end

@implementation WAINoDlownloadView
+ (instancetype)noDownloadViewWithType:(WAINoDownloadViewType)type{
    WAINoDlownloadView * noDataView = [self WAI_ViewFromXib];
    if (type == WAINoDownloadViewTypeLoaded) {
        noDataView.noDataImageView.image = [UIImage imageNamed:@"noData_download"];
    }else if (type == WAINoDownloadViewTypeLoading){
        noDataView.noDataImageView.image = [UIImage imageNamed:@"noData_downloading"];
    }
    return noDataView;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}
- (IBAction)goView {
    if (self.clickBlock != nil) {
        self.clickBlock();
    }
}
@end
