//
//  DVTSourceTextView+HOOK.m
//  JXSpeechCode
//
//  Created by dfxd on 16/5/27.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import "DVTSourceTextView+HOOK.h"





@implementation DVTSourceTextView (HOOK)
+ (void)load{
    
    
    [self jr_swizzleMethod:@selector(jx_selectFirstPlaceholderInCharacterRange:) withMethod:@selector(selectFirstPlaceholderInCharacterRange:) error:nil];
    [self jr_swizzleMethod:@selector(jx_adjustTypeOverCompletionForSelectionChange:) withMethod:@selector(adjustTypeOverCompletionForSelectionChange:) error:nil];
    
    
}

//获得输入文本的位置
- (BOOL)jx_selectFirstPlaceholderInCharacterRange:(struct _NSRange)arg1{
    
    NSString * str = [self.textStorage.string substringWithRange:arg1];
    NSString * newStr = [[JXSpeechCode sharedPlugin] serializationString:str];

    [[JXSpeechCode sharedPlugin] speechCaptrueString:newStr];
    return [self jx_selectFirstPlaceholderInCharacterRange:arg1];
}

//获得选择的文本位置
- (void)jx_adjustTypeOverCompletionForSelectionChange:(struct _NSRange)arg1{
    
    
    [self jx_adjustTypeOverCompletionForSelectionChange:arg1];
    
    if (arg1.length == 0) {
        [[JXSpeechCode sharedPlugin] stopSpeech];
        [[JXSpeechCode sharedPlugin] hiddenTextField];
        return;
    }
    NSString * captrueText = [self.textStorage.string substringWithRange:arg1];
    NSLog(@"---%@",captrueText);
    
    NSRect rect = [self frameForRange:arg1 ignoreWhitespace:NO];
    NSString * serializationText = [[JXSpeechCode sharedPlugin] serializationString:captrueText];
    [[JXSpeechCode sharedPlugin] speechCaptrueString:captrueText];
    [[JXSpeechCode sharedPlugin] translationString:serializationText completion:^(NSString *results) {
        
        CGFloat maxW = MAX(400, NSWidth(rect));
        CGRect textRect = [results boundingRectWithSize:NSMakeSize(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[NSFont systemFontOfSize:16.0f]}];
        textRect.size.height += 6;
        textRect.size.width += 8;
        
        NSRect displayRect;
        displayRect.size = textRect.size;
        displayRect.origin.x = rect.origin.x;
        displayRect.origin.y = rect.origin.y - textRect.size.height;
        NSLog(@"-----%@",NSStringFromRect(displayRect));
        [[JXSpeechCode sharedPlugin] displayTextFieldWithFrame:displayRect superView:self stringValue:results];
        
    }];
    
    
    
    
    
   
    
    

   
}





@end
