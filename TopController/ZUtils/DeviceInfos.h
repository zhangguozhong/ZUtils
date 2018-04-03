//
//  ZUtils.h
//  TopController
//
//  Created by 张国忠 on 2018/4/3.
//  Copyright © 2018年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DeviceInfos : NSObject


/**
 设备是否iPhone X

 @return YES OR NO
 */
+ (BOOL)getIs_iPhoneX;


/**
 判断当前系统版本是否低于指定的版本

 @param version 指定系统版本
 @return YES OR NO
 */
+ (BOOL)getIs_GreaterVersion:(NSString *)version;


@end
