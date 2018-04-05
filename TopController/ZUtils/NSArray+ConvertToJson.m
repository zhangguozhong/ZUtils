//
//  NSArray+ZUtils.m
//  TopController
//
//  Created by user on 2018/3/21.
//  Copyright © 2018年 user. All rights reserved.
//

#import "NSArray+ConvertToJson.h"

@implementation NSArray (ConvertToJson)

- (NSString *)toJsonString {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    
    if (error) {
        NSLog(@"error is %@", [error localizedDescription]);
        return nil;
    }
    if (!jsonData) {
        return nil;
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSData *)toJsonData {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    
    if (error) {
        NSLog(@"error is %@", [error localizedDescription]);
        return nil;
    }
    if (!jsonData) {
        return nil;
    }
    
    return jsonData;
}

@end
