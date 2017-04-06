//
//  Nav_Base_VC.m
//  SOFTDA
//
//  Created by 郑冰津 on 16/7/20.
//  Copyright © 2016年 IceGod. All rights reserved.
//

#import "Nav_Base_VC.h"

@interface Nav_Base_VC ()

@end

@implementation Nav_Base_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ///下面这个属性设置为NO的时候(不透明的底部标签栏),没有高斯模糊效果.设置为YES或者NO,对self.view都没有任何影响效果,总是占据49的距离
    self.tabBarController.tabBar.translucent = NO;
    ///这一句不注明,会因为按下home键,再次启动APP信号栏会有黑色的问题!,因为NAV本身是黑色的
    [self.view setBackgroundColor:[UIColor whiteColor]];
    ///设置NAV显示的颜色
    self.navigationBar.barTintColor = RGBA_Color(199, 164, 249, 1);
}
- (BOOL)prefersStatusBarHidden{
    return NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (UIViewController*)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

- (UIViewController*)childViewControllerForStatusBarHidden{
    return self.topViewController;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.viewControllers.count>0){
        viewController.hidesBottomBarWhenPushed=YES; //当push 的时候隐藏底部兰
    }
    [super pushViewController:viewController animated:animated];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    UIViewController *VC=(self.viewControllers[self.viewControllers.count-1]);
    if ([(self.viewControllers[0]) isEqual:self.viewControllers[self.viewControllers.count-1]]) {
        VC.hidesBottomBarWhenPushed=NO;
    }else{
        VC.hidesBottomBarWhenPushed=YES;
    }
    [super popViewControllerAnimated:animated];
    return self.viewControllers[self.viewControllers.count-1];
}
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([(UIViewController *)(self.viewControllers[0]) isEqual:viewController]) {
        viewController.hidesBottomBarWhenPushed=NO;
    }else{
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [super popToViewController:viewController animated:animated];
    return self.viewControllers;
}
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated{
    UIViewController *VC=(self.viewControllers[0]);
    VC.hidesBottomBarWhenPushed=NO;
    [super popToRootViewControllerAnimated:animated];
    return self.viewControllers;
}


@end
