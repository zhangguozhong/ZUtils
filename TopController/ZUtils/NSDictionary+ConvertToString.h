//
//  NSDictionary+ConvertToString.h
//  TopController
//
//  Created by user on 2018/3/21.
//  Copyright © 2018年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ConvertToString)


/**
 json对象转字符串

 @return json字符串
 */
- (NSString *)toJsonString;


/**
 json对象转url的query字符串

 @return url的query字符串
 */
- (NSString *)toQueryString;


@end
