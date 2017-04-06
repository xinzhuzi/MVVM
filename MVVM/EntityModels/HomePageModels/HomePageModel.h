//
//  HomePageModel.h
//  MVVM
//
//  Created by 郑冰津 on 2017/4/6.
//  Copyright © 2017年 JMKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageModel : NSObject

@property (nonatomic,strong)NSString *contentText;
@property (nonatomic,strong)NSString *detailText;
@property (nonatomic,strong)NSString *imageName;

///假数据
+ (NSMutableArray <HomePageModel *>*)loadData:(NSArray *)data;

@end

/*
  Model的职责:原始数据的解析以及包装
 */
