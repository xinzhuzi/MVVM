//
//  HomePage_VC.m
//  MVVM
//
//  Created by 郑冰津 on 2017/4/6.
//  Copyright © 2017年 JMKJ. All rights reserved.
//

#import "HomePage_VC.h"
#import "HomePageViewModel.h"
#import "HomePageView.h"
#import "HomePageDetail_VC.h"

@interface HomePage_VC ()
@property (nonatomic,strong)HomePageViewModel *viewModel;
@property (nonatomic,strong)HomePageView *mainView;

@end

@implementation HomePage_VC

#pragma mark -------overwrite

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(_rightBarButtonItemClickAction)];
    [self _eventFlowDirection];
    @weakify(self);
    ///最后请求数据,展示业务
    [self.viewModel requestData:^{
        @strongify(self);
        [self.mainView.mainTableView reloadData];
    }];
}

#pragma mark -------custom method
///这个地方代表了各种事件流的流向导出等等
- (void)_eventFlowDirection{
    RAC(self.mainView,testString)=RACObserve(self.viewModel, textString);
    @weakify(self);
    [[self.mainView rac_signalForSelector:@selector(HomePageViewTestEventActionFlow) fromProtocol:@protocol(HomePageViewDelegate)] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.viewModel testSendEventAction];
    }];
    ///转换事件,事件流导向(push present)
    [[self.viewModel rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)] subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(UITableView *tableView,NSIndexPath *indexPath)=x;
        if (tableView.editing) return ;
        @strongify(self);
        ///尽量写上这个回调主线程的方式
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (indexPath.row) {
                case 0:
                {
                    [self.navigationController pushViewController:[NSClassFromString(@"HomePageDetail_VC") new] animated:YES];
                }
                    break;
                case 1:
                {
                    UIViewController *VC =[NSClassFromString(@"HomePageDetail_VC") new];
                    [self presentViewController:VC animated:YES completion:nil];
                }
                    break;
                case 2:
                {
                    
                }
                    break;
                default:
                    break;
            }
        });
        tableView = nil;
    }];
}
- (void)_rightBarButtonItemClickAction{
    NSLog(@"这个事件流需要分发向view传递,或者向view和viewModel传递,或者只向viewModel传递");
}

//#pragma mark -------KVOKVC/Notification
//#pragma mark -------fixed data
#pragma mark -------getters and setters method

- (HomePageView *)mainView{
    if (!_mainView) {
        _mainView = [[HomePageView alloc] initWithFrame:CGRectMake(0, KNavHeight, self.view.width, self.view.height-KNavHeight-KTabbarHeight)];
        _mainView.mainTableView.delegate=self.viewModel;
        _mainView.mainTableView.dataSource=self.viewModel;
    }
    return _mainView;
}

- (HomePageViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[HomePageViewModel alloc]init];
    }
    return _viewModel;
}

@end
