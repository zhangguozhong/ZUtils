//
//  UIViewController+ZTopViewController.m
//  CurrentViewControllerDemo
//
//  Created by user on 2018/1/24.
//  Copyright © 2018年 user. All rights reserved.
//

#import "UIViewController+ZTopViewController.h"

@implementation UIViewController (ZTopViewController)

-(UIViewController*)currentVC{
    UIViewController *currentVC = [self getCurrentVCFromRootVC:[UIApplication sharedApplication].keyWindow.rootViewController];
//    while (currentVC.presentedViewController) {
//        // 视图是被presented出来的
//        currentVC=[self getCurrentVCFromRootVC:currentVC.presentedViewController];
//    }
    return currentVC;
}

-(UIViewController*)getCurrentVCFromRootVC:(UIViewController*)rootVC{
    UIViewController *currentVC;
    if (rootVC.presentedViewController) {
        // 视图是被presented出来的（但如果presented出来多个视图并不是UITabBarController或者UINavigationController，rootVC.presentedViewController获取到的视图就有可能不是最顶部的视图，因此需要再次递归）
        // rootVC=rootVC.presentedViewController; (有可能获取不到最顶部视图)
        rootVC=[self getCurrentVCFromRootVC:rootVC.presentedViewController];
    }
    if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 视图为UITabBarController
       currentVC = [self getCurrentVCFromRootVC:[(UINavigationController*)rootVC topViewController]];
    }else if ([rootVC isKindOfClass:[UITabBarController class]]){
        // 视图为UINavigationController
        currentVC=[self getCurrentVCFromRootVC:[(UITabBarController*)rootVC selectedViewController]];
    }else{
        currentVC=rootVC;
    }
    return currentVC;
}

@end
