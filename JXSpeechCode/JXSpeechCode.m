//
//  ChaJian.m
//  ChaJian
//
//  Created by dfxd on 16/5/9.
//  Copyright © 2016年 dfxd. All rights reserved.
//


#import "JXSpeechCode.h"
#import <objc/runtime.h>
#import "JXSpeech.h"
#import "NSString+JXRegular.h"
#import "JXShowContentWindow.h"

#define WINDOW_MAX_WIDTH 400
#define WINDOW_MAX_HIGHT MAXFLOAT

static NSString * expression = @"[a-zA-Z][a-z]*[a-z]";
static NSString * expressionRemove = @"(<#)[^#>]*(#>)";

@interface JXSpeechCode()

@property (nonatomic, strong, readwrite) NSBundle *bundle;

@end
  
@implementation JXSpeechCode


- (JXSpeech *)speech{
    _speech = _speech?_speech:[JXSpeech new];
    return _speech;
}

- (JXTranslation *)translation{
    
    _translation = _translation?_translation:[JXTranslation new];
    return _translation;
}


+ (instancetype)sharedPlugin
{
    return sharedPlugin;
    
}




- (id)initWithBundle:(NSBundle *)plugin{
    
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        sharedPlugin = self;
        _isSpeech = YES;
        _isTranslation = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}





- (void)didApplicationFinishLaunchingNotification:(NSNotification*)not{
    

    //removeObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (menuItem) {
        
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Action Speech" action:@selector(doMenuAction:) keyEquivalent:@""];
        actionMenuItem.state = 1;
        [actionMenuItem setKeyEquivalentModifierMask:NSAlphaShiftKeyMask | NSControlKeyMask];
        [actionMenuItem setTag:10000];
        [actionMenuItem setTarget:self];
        [[menuItem submenu] addItem:actionMenuItem];
        
         NSMenuItem * selecteMenuItem = [[NSMenuItem alloc] initWithTitle:@"Action Translation" action:@selector(doMenuAction:) keyEquivalent:@""];
        selecteMenuItem.state = 1;
        [selecteMenuItem setKeyEquivalentModifierMask:NSAlphaShiftKeyMask | NSControlKeyMask];
        [selecteMenuItem setTag:20000];
        [selecteMenuItem setTarget:self];
        [[menuItem submenu] addItem:selecteMenuItem];
        
    }
}





// Sample Action, for menu item:
- (void)doMenuAction:(NSMenuItem *)sender
{
    sender.state = sender.state == 0?1:0;
    if (sender.tag == 10000) {
        _isSpeech = sender.state;
        return;
    }
    _isTranslation = sender.state;
    
}

#pragma mark - 播音
- (BOOL)speaking{
    return self.speech.isSpeaking;
}

- (void)speechCaptrueString:(NSString *)str{
    if (!self.isSpeech)return;
    if (self.speaking) {
        [self stopSpeech];
    }
    
   
    NSDate * date = [NSDate date];
    [self performSelectorInBackground:@selector(speakingText:) withObject:str];
    //[self speakingText:str];
    NSTimeInterval space = [date timeIntervalSinceDate:[NSDate date]];
    
    NSLog(@"%f",space);
}

- (void)speakingText:(NSString *)str{
    [self.speech startSpeakingString:str];
}

- (void)stopSpeech{
    [self.speech stopSpeaking];
}

#pragma mark - 翻译

- (void)translationString:(NSString *)str completion:(void (^)(NSString *))completion{
    
    
    if (!_isTranslation) return;
    
    
    [self.translation chineseWithEnglishWord:str completion:completion];
}

#pragma mark - 字符串序列化

- (NSString *)serializationString:(NSString *)str{
    
    NSMutableString * newString = [NSMutableString stringWithString:str];
    {//移除文本中的(< ## >)中的内容
        NSMutableArray * array = [str getTheResultFromTheExpression:expressionRemove].mutableCopy;

        while (array.count > 0) {
            NSTextCheckingResult * result = [array lastObject];
            [newString deleteCharactersInRange:result.range];
            [array removeObject:result];
        }
    }
    {//分离单词
        NSArray * array = [newString getTheTextFromTheExpression:expression];
        [newString deleteCharactersInRange:NSMakeRange(0, newString.length)];
        for (NSString * str in array) {
            [newString appendFormat:@"%@ ",str];
        }
        
    }
    NSCharacterSet * ws = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    newString = [newString stringByTrimmingCharactersInSet:ws].mutableCopy;
    newString = [newString lowercaseString].mutableCopy;
    return newString;
}

#pragma mark - 显示 隐藏

- (void)displayShowWindowWithFrame:(NSRect)frame stringValue:(NSString *)stringValue{
    if (!_isTranslation) return;
    if (!_showWindow) {
        _showWindow = [[JXShowContentWindow alloc] initWithContentRect:NSZeroRect];
    }
    _showWindow.text = stringValue;
    [_showWindow showWindowWithFrame:frame];
}

//更新位置
- (void)updataWindowPointX:(CGFloat)x{
    if (x != NSMinX(_showWindow.frame)) {
        [_showWindow setFrameOrigin:NSMakePoint(x, NSMinY(_showWindow.frame))];
    }
}

- (void)hiddenShowWindow{
    [_showWindow hidden];
    
}


// textFiled
- (void)displayTextFieldWithFrame:(NSRect)frame superView:(NSView *)view stringValue:(NSString *)stringValue{
    if (!_isTranslation) return;
    if (!_textField) {
        _textField = [[NSTextField alloc] init];
        _textField.backgroundColor = [NSColor yellowColor];
        _textField.font = [NSFont systemFontOfSize:16.0f];
        _textField.editable = NO;
        _textField.bezelStyle = NSRecessedBezelStyle;
    }
    if (_textField.superview != view) {
        [view addSubview:_textField];
    }
    _textField.frame = frame;
    _textField.stringValue = stringValue;
    _textField.hidden = NO;
    
}

- (void)hiddenTextField{
    _textField.hidden = YES;
}







- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
