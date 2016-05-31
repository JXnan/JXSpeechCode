//
//  JXSpeechCode.h
//  JXSpeechCode
//
//  Created by dfxd on 16/5/12.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "JXTranslation.h"
#import "JXSpeech.h"
@class JXShowContentWindow;
@class JXSpeechCode;

static JXSpeechCode *sharedPlugin;

@interface JXSpeechCode : NSObject




@property(nonatomic,strong) JXSpeech * speech;
@property(nonatomic,strong) JXTranslation * translation;

@property(nonatomic,assign) BOOL isSpeech;
@property(nonatomic,assign) BOOL isTranslation;
@property(nonatomic,assign) BOOL speaking;

@property(nonatomic,strong) NSTextField * textField;
@property(nonatomic,strong) JXShowContentWindow * showWindow;

@property (nonatomic, strong, readonly) NSBundle* bundle;


+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

- (void)speechCaptrueString:(NSString *)str;
- (void)stopSpeech;

- (NSString *)serializationString:(NSString *)str;
- (void)translationString:(NSString *)str completion:(void(^)(NSString * results))completion;


- (void)displayTextFieldWithFrame:(NSRect)frame superView:(NSView *)view stringValue:(NSString *)stringValue;
- (void)hiddenTextField;

- (void)displayShowWindowWithFrame:(NSRect)frame stringValue:(NSString *)stringValue;
- (void)updataWindowPointX:(CGFloat)x;
- (void)hiddenShowWindow;


@end