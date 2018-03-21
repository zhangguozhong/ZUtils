//
//  NSDictionary+ConvertToString.m
//  TopController
//
//  Created by user on 2018/3/21.
//  Copyright © 2018年 user. All rights reserved.
//

#import "NSDictionary+ConvertToString.h"
#import "NSArray+ConvertToJson.h"

@implementation NSDictionary (ConvertToString)

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

- (NSString *)toQueryString {
    
    if (self.count==0) {
        return nil;
    }
    
    NSMutableString *queryString = [[NSMutableString alloc] initWithString:@"?"];
    NSMutableArray *hasKeys = [NSMutableArray array];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull objValue, BOOL * _Nonnull stop) {
        
        [hasKeys addObject:key];
        if (key && objValue) {
            if ([objValue isKindOfClass:[NSArray class]]) {
                objValue = [objValue toJsonString];
            }
            NSString *queryItem = [NSString stringWithFormat:@"%@=%@",key,objValue];
            [queryString appendString:queryItem];
        }
        if (hasKeys.count != self.count) {
            [queryString appendString:@"&"];
        }
    }];
    
    return [queryString copy];
}

@end
