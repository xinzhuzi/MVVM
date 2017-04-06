//
//  Parent_Class_VC.m
//  SOFTDA
//
//  Created by 郑冰津 on 16/7/20.
//  Copyright © 2016年 IceGod. All rights reserved.
//

#import "Parent_Class_VC.h"

@interface Parent_Class_VC ()

@end

@implementation Parent_Class_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    ///下面这个属性设置为NO的时候(不透明的导航栏),没有高斯模糊效果,此时会向下方移动64的距离
    self.navigationController.navigationBar.translucent = NO;
    ///下面这个属性,当设置为不透明的导航栏的时候,需要把属性设置成为YES,充满全屏
    self.extendedLayoutIncludesOpaqueBars = YES;
    ///这个属性默认是UIRectEdgeAll,充满全屏
    self.edgesForExtendedLayout = UIRectEdgeAll;
    ///当前此界面有UIScrollView被加载的时候,把此属性设置为NO,充满全屏
    self.automaticallyAdjustsScrollViewInsets = NO;
    ///下面这个属性设置为NO的时候(不透明的底部标签栏),没有高斯模糊效果.设置为YES或者NO,对self.view都没有任何影响效果,总是占据49的距离
    self.navigationController.tabBarController.tabBar.translucent = NO;
    
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end


/*
 for (UIView *vi in self.navigationController.navigationBar.subviews) {
 vi.backgroundColor = [UIColor whiteColor];
 vi.alpha = 1.0f;
 vi.layer.masksToBounds = YES;
 for (UIView *vii in vi.subviews) {
 vii.backgroundColor = [UIColor whiteColor];
 vii.alpha = 1.0f;
 vii.layer.masksToBounds = YES;
 for (UIView *viii in vii.subviews) {
 if ([viii isKindOfClass:NSClassFromString(@"_UIVisualEffectFilterView")]) {
 viii.backgroundColor = [UIColor whiteColor];
 viii.alpha = 1.0f;
 ///高斯模糊效果移除,则像素混合没有Color Blended Layers测试达到最优化
 [viii removeFromSuperview];
 }else{
 viii.backgroundColor = [UIColor whiteColor];
 viii.alpha = 1.0f;
 viii.layer.masksToBounds = YES;
 ///为了不让其离屏渲染,整个屏幕都是屎黄色(离屏渲染),(好像日了狗了一样的心情,这_UIVisualEffectBackdropView有毒)
 [viii removeFromSuperview];
 }
 }
 }
 }
 */
