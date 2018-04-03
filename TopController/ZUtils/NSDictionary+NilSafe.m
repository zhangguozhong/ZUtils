//
//  NSDictionary+NilSafe.m
//  TopController
//
//  Created by 张国忠 on 2018/3/23.
//  Copyright © 2018年 user. All rights reserved.
//

#import "NSDictionary+NilSafe.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)

+ (BOOL)dz_originalMethod:(SEL)originalSelector swizzleMethod:(SEL)swizzleSelector {
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzleMethod = class_getInstanceMethod(self, swizzleSelector);
    if (!originalMethod || !swizzleMethod) {
        return NO;
    }
    
    class_addMethod(self, originalSelector, class_getMethodImplementation(self, originalSelector), method_getTypeEncoding(originalMethod));
    class_addMethod(self, swizzleSelector, class_getMethodImplementation(self, swizzleSelector), method_getTypeEncoding(swizzleMethod));
    method_exchangeImplementations(class_getInstanceMethod(self, originalSelector), class_getInstanceMethod(self, swizzleSelector));
    return YES;
}

+ (BOOL)dz_originalClassMethod:(SEL)originalSelector swizzleMethod:(SEL)swizzleSelector {
    return [object_getClass((id)self) dz_originalMethod:originalSelector swizzleMethod:swizzleSelector];
}

@end


@implementation NSDictionary (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self dz_originalMethod:@selector(initWithObjects:forKeys:count:) swizzleMethod:@selector(dz_initWithObjects:forKeys:count:)];
        [self dz_originalClassMethod:@selector(dictionaryWithObjects:forKeys:count:) swizzleMethod:@selector(dz_dictionaryWithObjects:forKeys:count:)];
    });
}

- (instancetype)dz_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id object = objects[i];
        if (!key || !object) {
            continue;
        }
        safeKeys[j] = key;
        safeObjects[j] = object;
        j++;
    }
    
    return [self dz_initWithObjects:safeObjects forKeys:safeKeys count:j];
}


+ (instancetype)dz_dictionaryWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id object = objects[i];
        if (!key || !object) {
            continue;
        }
        if (!object) {
            object = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = object;
        j++;
    }
    
    return [self dz_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
}

@end
