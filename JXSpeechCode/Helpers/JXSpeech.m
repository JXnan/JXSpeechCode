//
//  JXSpeech.m
//  ChaJian
//
//  Created by dfxd on 16/5/12.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import "JXSpeech.h"
#import <AppKit/AppKit.h>
   
@interface JXSpeech()<NSSpeechSynthesizerDelegate>

@end

@implementation JXSpeech
{
    NSSpeechSynthesizer * _speech;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        _speech = [[NSSpeechSynthesizer alloc] init];
    }
    return self;
}

- (void)startSpeakingString:(NSString *)string compel:(BOOL)compel{
    if (compel && _speech.isSpeaking) {
        [_speech stopSpeaking];
    }
    [_speech startSpeakingString:string];
}

- (void)startSpeakingString:(NSString *)string{
    [_speech startSpeakingString:string];
}

- (void)stopSpeaking{
    [_speech stopSpeaking];
}

- (BOOL)isSpeaking{
    return _speech.isSpeaking;
}





@end
