//
//  NSString+JXRegular.m
//  ab
//
//  Created by admin on 15-12-27.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "NSString+JXRegular.h"
   
@implementation NSString (JXRegular)


- (BOOL)beganMatchWithType:(NSString *)type{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"self matches %@",type];
    return [predicate evaluateWithObject:self];
}

- (NSArray <NSString *> *)getTheTextFromTheExpression:(NSString *)expression{
    NSMutableArray * array = [NSMutableArray array];
    NSArray * resultArray = [self getTheResultFromTheExpression:expression];
    for (NSTextCheckingResult * obj in resultArray) {
        NSString * str  = [self substringWithRange:obj.range];
        [array addObject:str];
    }
    return array;
    
}

- (NSArray<NSTextCheckingResult *> *)getTheResultFromTheExpression:(NSString *)expression{
  
    NSRegularExpression * regular = [[NSRegularExpression alloc] initWithPattern:expression options:0 error:nil];
    NSArray * resultArray = [regular matchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    return resultArray;
}
@end
