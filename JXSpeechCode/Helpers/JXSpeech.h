//
//  JXSpeech.h
//  ChaJian
//
//  Created by dfxd on 16/5/12.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import <Foundation/Foundation.h>
   
@interface JXSpeech : NSObject
@property(nonatomic,assign,readonly)BOOL isSpeaking;
@property(nonatomic,assign)NSInteger speakGrade;

- (void)startSpeakingString:(NSString *)string compel:(BOOL)compel;
- (void)startSpeakingString:(NSString *)string;
- (void)stopSpeaking;
@end
