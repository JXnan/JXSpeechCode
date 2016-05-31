//
//  JXTranslation.h
//  JXSpeechCode
//
//  Created by dfxd on 16/5/17.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface JXTranslation : NSObject
@property(nonatomic,strong)NSDictionary * dicLibrary;
@property(nonatomic,assign)CGRect rect;
@property(nonatomic,strong)AFHTTPSessionManager * manager;
@property(nonatomic,strong)NSMutableDictionary * requestDic;

//+ (instancetype)sharedPlugin;
- (instancetype)initWithDictionary:(NSDictionary *)dic;


- (void)chineseWithEnglishWord:(NSString *)string completion:(void(^)(NSString * string))completion;
- (void)chineseWithEnglishSentence:(NSString *)string completion:(void(^)(NSString * string))completion;
@end
