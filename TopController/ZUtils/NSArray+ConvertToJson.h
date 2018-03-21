//
//  NSArray+ZUtils.h
//  TopController
//
//  Created by user on 2018/3/21.
//  Copyright © 2018年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ConvertToJson)


/**
 数组对象转字符串

 @return json字符串
 */
- (NSString *)toJsonString;


/**
 数组对象转data对象

 @return data对象
 */
- (NSData *)toJsonData;


@end
