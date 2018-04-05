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
    if (self.count == 0) {
        return nil;
    }
    
    NSMutableString *queryString = [[NSMutableString alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull strKey, id  _Nonnull objValue, BOOL * _Nonnull stop) {
        
        if (strKey && objValue) {
            NSString *strObjValue;
            if ([objValue isKindOfClass:[NSArray class]]) {
                strObjValue = [objValue toJsonString];
            }else{
                strObjValue = objValue;
            }
            
            if (strObjValue && strObjValue.length > 0) {
                if (queryString.length == 0) {
                    NSString *queryItem = [NSString stringWithFormat:@"?%@=%@",strKey,strObjValue];
                    [queryString appendString:queryItem];
                }else{
                    NSString *queryItem = [NSString stringWithFormat:@"&%@=%@",strKey,strObjValue];
                    [queryString appendString:queryItem];
                }
            }
        }
    }];
    
    return [queryString copy];
}

@end
