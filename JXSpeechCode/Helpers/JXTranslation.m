//
//  JXTranslation.m
//  JXSpeechCode
//
//  Created by dfxd on 16/5/17.
//  Copyright © 2016年 dfxd. All rights reserved.
//


#define URL         @"http://fanyi.youdao.com/openapi.do?"

#define K_key       @"909957880"
#define K_keyfrom   @"sadada"
#define K_type      @"data"
#define K_doctype   @"json"
#define K_version   @"1.1"

#define P_keyfrom   @"keyfrom"
#define P_key       @"key"
#define P_type      @"type"
#define P_doctype   @"doctype"
#define P_version   @"version"
#define P_q         @"q"

#import "JXTranslation.h"

#import "AFNetworking.h"




@implementation JXTranslation
static JXTranslation * translation;


- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        if (dic) {
            _dicLibrary = dic;
        }
    }
    return self;
}
- (instancetype)init{
    self  = [super init];
    if (self) {
        NSString * pluginPath = @"~/Library/Application Support/Developer/Shared/Xcode/Plug-ins/JXSpeechCode.xcplugin";
        NSBundle * pluginBundle = [NSBundle bundleWithPath:[pluginPath stringByExpandingTildeInPath]];
        NSString * dicPath = [pluginBundle pathForResource:@"word" ofType:@"plist"];
        NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
        _dicLibrary = [dic valueForKey:@"dic"];
        
    }
    return self;
}


#pragma mark - block
- (void)chineseWithEnglishWord:(NSString *)string completion:(void (^)(NSString *))completion{
   NSString * response = @"翻译失败!";
    NSLog(@"%@",string);
    

    if ([string rangeOfString:@" "].length == 0) {//是否多个单词
        if ([[_dicLibrary allKeys] containsObject:string]) {//是否存在
            response = [_dicLibrary objectForKey:string ];
            if (completion) {
                completion(response);
            }
            return;
        }
    }
    [self chineseWithEnglishSentence:string completion:completion];
    
    
}

- (void)chineseWithEnglishSentence:(NSString *)string completion:(void (^)(NSString *))completion{

    [self.requestDic setValue:string forKey:P_q];
    [self.manager GET:URL parameters:self.requestDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSLog(@"成功");

        if (completion) {
            if ([[responseObject valueForKey:@"errorCode"] integerValue] == 0) {
                completion([[responseObject valueForKey:@"translation"] objectAtIndex:0]);
            }else{
                completion(@"翻译失败!可能是太长了");
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(@"翻译失败!");
        }
        NSLog(@"失败---%@",error);
    }];
    
}

- (NSMutableDictionary *)requestDic{
    if (!_requestDic) {
        _requestDic = [[NSMutableDictionary alloc] init];
        [_requestDic setValue:K_keyfrom forKey:P_keyfrom];
        [_requestDic setValue:K_key forKey:P_key];
        [_requestDic setValue:K_type forKey:P_type];
        [_requestDic setValue:K_doctype forKey:P_doctype];
        [_requestDic setValue:K_version forKey:P_version];
    }
    return _requestDic;
}

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return _manager;
}

@end
