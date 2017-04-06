//
//  HomePageViewModel.m
//  MVVM
//
//  Created by 郑冰津 on 2017/4/6.
//  Copyright © 2017年 JMKJ. All rights reserved.
//

#import "HomePageViewModel.h"
#import "HomePageModel.h"
#import "HomePageView.h"

@interface HomePageViewModel ()

@property (nonatomic,strong)NSMutableArray <HomePageModel *>*arrayData;
@property (nonatomic,strong)NSMutableArray <NSNumber *>*arraySelected;

@end
@implementation HomePageViewModel
#pragma mark -------overwrite

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arraySelected=@[].mutableCopy;
    }
    return self;
}

#pragma mark -------custom method

- (void)testSendEventAction{
    NSLog(@"事件流传递到了VM中,做处理吧");
}

- (void)requestData:(void(^)())block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *data = @[].mutableCopy;
        for (int i = 0; i<20; i++) {
            NSString *contentText = [NSString stringWithFormat:@"郑冰津无聊了%d次",i];
            NSString *detailText = [NSString stringWithFormat:@"郑冰津特想做一首诗,来证明他爱大家%d次",i];
            NSString *imageName = @"girlsLaughter.jpeg";
            NSDictionary *dict =  NSDictionaryOfVariableBindings(contentText,detailText,imageName);
            [data addObject:dict];
            [self.arraySelected addObject:[NSNumber numberWithBool:NO]];
        }
        self.textString = @"事件返还流向 VM->V";
        self.arrayData = [HomePageModel loadData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    });
}

//#pragma mark -------KVOKVC/Notification
//#pragma mark -------fixed data

#pragma mark -----------UITableViewDelegate,UITableViewDataSource-----------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomePageTableViewHeader *tableViewHeader =(HomePageTableViewHeader *)[HomePageTableViewHeader defaultHomePageTableViewHeader:tableView section:section];
    if([tableViewHeader respondsToSelector:@selector(HomePageTableViewHeaderClickAction:)]) return tableViewHeader;
    @weakify(self);
    ///编辑/全选/取消事件流向
    [[tableViewHeader rac_signalForSelector:@selector(HomePageTableViewHeaderClickAction:) fromProtocol:@protocol(HomePageViewDelegate)] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        RACTupleUnpack(NSNumber * numberType) = x;
        if ([numberType integerValue]==HomePageTableViewHeaderAction_ChackAll) {
            for (int i = 0 ; i<self.arraySelected.count; i++) {
                [self.arraySelected replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:YES]];
            }
            [tableView reloadData];
        }else if ([numberType integerValue]==HomePageTableViewHeaderAction_Editing){
            [tableView setEditing:YES animated:YES];
            [tableView reloadData];
        }else if ([numberType integerValue]==HomePageTableViewHeaderAction_Cancel){
            [tableView setEditing:NO animated:YES];
            for (int i = 0 ; i<self.arraySelected.count; i++) {
                [self.arraySelected replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:NO]];
            }
            [tableView reloadData];
        }
    }];
    return tableViewHeader;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomePageModel *model = self.arrayData[indexPath.row];
    HomePageTableViewCell *cell = [HomePageTableViewCell defaultHomePageTableViewCell:tableView indexPath:indexPath text:model.contentText detailText:model.detailText imageName:model.imageName selected:[self.arraySelected[indexPath.row] boolValue]];
    ///如果cell上面有自定义按钮点击事件等,按照HomePageTableViewHeader做法在这个地方进行事件流接收
    return cell;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.arraySelected replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){
    [self.arraySelected replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
}
#pragma mark -------getters and setters method

@end






