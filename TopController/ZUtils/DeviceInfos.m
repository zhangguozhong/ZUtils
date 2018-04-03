//
//  ZUtils.m
//  TopController
//
//  Created by 张国忠 on 2018/4/3.
//  Copyright © 2018年 user. All rights reserved.
//

#import "DeviceInfos.h"
#import <sys/utsname.h>

@implementation DeviceInfos

+ (BOOL)getIs_iPhoneX {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"]) {
        return YES;
    }else{
        return NO;
    }
}


+ (BOOL)getIs_GreaterVersion:(NSString *)version {
    return [[UIDevice currentDevice].systemVersion compare:version options:NSNumericSearch] != NSOrderedAscending;
}

@end
