//
//  WAITodayFireVoiceListVC.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/29.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAITodayFireVoiceListVC.h"
#import "WAIDownLoadVoiceModel.h"
#import "WAIDownLoadDataTool.h"
#import "WAITodayFireVoiceCell.h"
#import "WAISetValueTool.h"


@interface WAITodayFireVoiceListVC ()
@property (nonatomic,strong) NSArray<WAIDownLoadVoiceModel *> * voiceMs;
@property (nonatomic, weak) NSTimer *updateTimer;
@end

@implementation WAITodayFireVoiceListVC
-(void)setVoiceMs:(NSArray<WAIDownLoadVoiceModel *> *)voiceMs{
    _voiceMs = voiceMs;
    [self.tableView reloadData];
}
-(void)setLoadKey:(NSString *)loadKey{
    _loadKey = loadKey;
    WAIWeakSelf;
    [[WAIDownLoadDataTool shareInstance] getVoiceMsWithKey:loadKey pageNum:1 result:^(NSArray<WAIDownLoadVoiceModel *> * _Nonnull voiceMs) {
        weakSelf.voiceMs = voiceMs;
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.voiceMs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WAITodayFireVoiceCell * cell = [WAITodayFireVoiceCell cellWithTableView:tableView];
    WAIDownLoadVoiceModel * model = self.voiceMs[indexPath.row];
//    __weak WAIDownLoadVoiceModel * weakModel = model;
    model.clickBlock = ^{
//      [WAIDownLoadDataTool shareInstance]
        NSLog(@"model,click");
    };
    model.sortNum = indexPath.row + 1;
    [WAISetValueTool setModel:model toCell:cell];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
