//
//  HomePageView.h
//  MVVM
//
//  Created by 郑冰津 on 2017/4/6.
//  Copyright © 2017年 JMKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomePageTableViewHeader,HomePageTableViewCell;

typedef NS_ENUM(NSUInteger, HomePageTableViewHeaderAction) {
    HomePageTableViewHeaderAction_ChackAll = 99555,///全选
    HomePageTableViewHeaderAction_Editing,///编辑
    HomePageTableViewHeaderAction_Cancel,///取消
};

@protocol HomePageViewDelegate <NSObject>

@optional
///表头点击的方法
- (void)HomePageTableViewHeaderClickAction:(HomePageTableViewHeaderAction)type;
///测试事件流向
- (void)HomePageViewTestEventActionFlow;

@end

#pragma mark ===============Class HomePageView

@interface HomePageView : UIView<HomePageViewDelegate>

@property (nonatomic,strong,readonly)UITableView *mainTableView;
@property (nonatomic,strong,readonly)UIButton *testButton;
@property (nonatomic,strong,readonly)UIView *testView;

@property (nonatomic,strong)NSString *testString;

-(instancetype)initWithFrame:(CGRect)frame;
@end

#pragma mark ===============Class HomePageTableViewCell

@interface HomePageTableViewCell : UITableViewCell<HomePageViewDelegate>

+ (instancetype)defaultHomePageTableViewCell:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                        text:(NSString *)text
                                  detailText:(NSString *)detailText
                                   imageName:(NSString *)imageName
                                    selected:(BOOL)selected;

@end


#pragma mark ===============Class HomePageTableViewHeader

@interface HomePageTableViewHeader : UITableViewHeaderFooterView<HomePageViewDelegate>

@property (nonatomic,strong)UITextField *searchTextField;
@property (nonatomic,strong)UIButton *editCheckAllButton;
@property (nonatomic,strong)UIButton *cancelButton;

+ (instancetype)defaultHomePageTableViewHeader:(UITableView *)tableView section:(NSInteger )section;

@end

/*
 职责:UI控件的排布,动画,数据的展示(数据展示安排在这一层是为了更清晰的黑盒测试,如果安排在VM中,黑盒测试找到问题很麻烦(除非功力深厚或者对代码很熟悉才行))
 
 */
