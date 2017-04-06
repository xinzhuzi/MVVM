//
//  HomePageModel.m
//  MVVM
//
//  Created by 郑冰津 on 2017/4/6.
//  Copyright © 2017年 JMKJ. All rights reserved.
//

#import "HomePageModel.h"
#import <YYModel/YYModel.h>

@implementation HomePageModel

+ (NSMutableArray <HomePageModel *>*)loadData:(NSArray *)data{
    NSMutableArray <HomePageModel *>*result = @[].mutableCopy;
    for (NSDictionary *dict in data) {
        HomePageModel *model = [HomePageModel yy_modelWithJSON:dict];
        [result addObject:model];
    }
    return result;
}

@end
