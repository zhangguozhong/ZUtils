# ZUtils

封装好的一些常用的Category工具类，方便复用开发。
```objective-c
pod 'ZUtils'
```

## 方法

### NSArray
```objective-c
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
```

### NSDictionary
```objective-c
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
```

### NSString
```objective-c
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


```


## 使用
```objective-c
NSDictionary *dict = @{
                           @"name":@"zhangsan",
                           @"id":@"10001",
                           @"cournces":@[@"数学",@"语文"],
                           @"className":@"三年二班"
                           };
    NSLog(@"%@",[dict toQueryString]);
    
    //NSString *urlString = @"http://www.test.com/index.html?key=sgsgs&name=[\"1\",\"2\",\"3\"]#demo?className=的幸福感的&noId=1001";
    NSString *urlString = [NSString stringWithFormat:@"http://www.test.com/index.html%@",[dict toQueryString]];
    
    NSMutableCharacterSet *testCha = [[NSMutableCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    //[testCha addCharactersInString:@"#"] ;
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[testCha copy]]];
    
    NSLog(@"urlString---%@",[url absoluteString]);
    NSURLComponents *conponents = [NSURLComponents componentsWithString:[url absoluteString]];
    NSLog(@"test--%@",conponents.queryItems);
    
    for (NSURLQueryItem *queryItem in conponents.queryItems) {
        //if ([queryItem.value isKindOfClass:[NSArray class]]) {
            NSLog(@"%@ - %@",queryItem.name,[queryItem.value toJson]);
        //}
    }
    //NSLog(@"testStr -- %@",conponents.percentEncodedFragment);
    
    NSArray *testA = @[@"1",@"2",@"3"];
    NSLog(@"str -- %@",[testA toJsonString]);
```
