//
//  NSObject_Extension.m
//  JXSpeechCode
//
//  Created by dfxd on 16/5/12.
//  Copyright © 2016年 dfxd. All rights reserved.
//


#import "NSObject_Extension.h"
#import "JXSpeechCode.h"
  
@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    NSLog(@"%@",currentApplicationName);
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[JXSpeechCode alloc] initWithBundle:plugin];
           
        });
    }
}
@end
