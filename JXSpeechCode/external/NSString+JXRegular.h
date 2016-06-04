//
//  NSString+JXRegular.h
//  ab
//
//  Created by admin on 15-12-27.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
  
///wssss
#define JX_EMAIL            @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"//邮箱
#define JX_CHINESE          @"^[\u4e00-\u9fa5]{0,}$"//中文
#define JX_URL              @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"//URL
#define JX_POSTCODE         @"[1-9]\\d{5}(?!\d)"//中国邮编
#define JX_LETTER           @"^[A-Za-z]+$"//26字母
#define JX_LETTER_SMALL     @"^[a-z]+$"//小写
#define JX_LETTER_CAPITAL   @"^[A-Z]+$"//大写
#define JX_INT              @"^[0-9]*$"//数字
#define JX_IDENTITY         @"\\d{14}[[0-9],0-9xX]"//身份证号
#define JX_PHONE            @"^1[3|4|5|7|8][0-9]\\d{8}$"//手机号
#define JX_USERNAME         @"^[a-zA-Z]\w{5,15}$"//6－16位首位字母
#define JX_CHARS            @"^[A-Za-z0-9]+$"//只能输入数字和字母
#define JX_NUMBER           @"^[A-Za-z0-9]+$"//整数或小数
#define JX_SIGN             @"[^%&',;=?$\x22]+"//验证是否含有^%&',;=?$\"等字符
#define JX_DATE             @"\\d{4}[年|\-|\.]\\d{\1-\12}[月|\-|\.]\\d{\1-\31}日?"//日期
#define JX_QQ               @"[1-9][0-9]{4,}"//QQ
#define JX_TELEPHONE        @"\d{3}-\d{8}|\d{4}-\{7,8}"//座机号码
#define JX_XML              @"^([a-zA-Z]+-?)+[a-zA-Z0-9]+\\.[x|X][m|M][l|L]$"//匹配XML
#define JX_IP               @"((([1-9]?|1\d)\d|2([0-4]\d|5[0-5]))\.){3}(([1-9]?|1\d)\d|2([0-4]\d|5[0-5]))"//IP

@interface NSString (JXRegular)
///匹配正则
- (BOOL)beganMatchWithType:(NSString *)type;

- (NSArray <NSString *> *)getTheTextFromTheExpression:(NSString *)expression;

- (NSArray <NSTextCheckingResult *> *)getTheResultFromTheExpression:(NSString *)expression;

@end
