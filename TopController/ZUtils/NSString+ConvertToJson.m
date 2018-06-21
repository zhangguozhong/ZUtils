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

- (NSString *)toSortString {
    if (!self || self.length==0) {
        return nil;
    }
    
    NSMutableArray *sortItems = [NSMutableArray array];
    for (int i=0; i<self.length; i++) {
        NSString *item = [self substringWithRange:NSMakeRange(i, 1)];
        [sortItems addObject:item];
    }
    
    NSArray *sortAfterItems = [sortItems sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *sortString = [[sortAfterItems componentsJoinedByString:@","] stringByReplacingOccurrencesOfString:@"," withString:@""];
    if (sortString && sortString.length != 0) {
        return sortString;
    }

    return nil;
}

@end
