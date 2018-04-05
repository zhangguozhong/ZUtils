//
//  NSString+ConvertToJson.m
//  TopController
//
//  Created by user on 2018/3/21.
//  Copyright © 2018年 user. All rights reserved.
//

#import "NSString+ConvertToJson.h"

@implementation NSString (ConvertToJson)

- (id)toJson {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (!jsonData) {
        return nil;
    }
    
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    if (error) {
        NSLog(@"error is %@", [error localizedDescription]);
        return nil;
    }
    
    return jsonObj;
}

- (NSData *)stringToData {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

@end
