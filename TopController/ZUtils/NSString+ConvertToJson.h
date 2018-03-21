//
//  NSString+ConvertToJson.h
//  TopController
//
//  Created by user on 2018/3/21.
//  Copyright © 2018年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ConvertToJson)


/**
 字符串转json对象

 @return json对象
 */
- (id)toJson;


/**
 字符串转data对象

 @return data对象
 */
- (NSData *)stringToData;


@end
