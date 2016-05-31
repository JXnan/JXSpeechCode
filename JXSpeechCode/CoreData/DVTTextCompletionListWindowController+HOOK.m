//
//  DVTTextCompletionListWindowController+HOOK.m
//  JXSpeechCode
//
//  Created by dfxd on 16/5/27.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import "DVTTextCompletionListWindowController+HOOK.h"


@implementation DVTTextCompletionListWindowController (HOOK)
+ (void)load{
    
    [self jr_swizzleMethod:@selector(jx_showInfoPaneForCompletionItem:) withMethod:@selector(showInfoPaneForCompletionItem:) error:nil];
    [self jr_swizzleMethod:@selector(_hideWindow) withMethod:@selector(jx__hideWindow) error:nil];
    
}




- (void)jx_showWindowForTextFrame:(struct CGRect)arg1 explicitAnimation:(BOOL)arg2{
    [self jx_showWindowForTextFrame:arg1 explicitAnimation:arg2];
    NSLog(@"%@",NSStringFromRect(arg1));
   
}

- (void)jx_showInfoPaneForCompletionItem:(id)item
{
    [self jx_showInfoPaneForCompletionItem:item];
    
    if ([item isKindOfClass:[IDEIndexCompletionItem class]]) {
        IDEIndexCompletionItem * i = (IDEIndexCompletionItem*)item;
        //保存上次内容的东西 用来判断是否会重复
        static NSString *tag = @"";
        
        if ([tag isEqualToString:i.name]) {//相同内容,或许需要移动X位置呢
            [[JXSpeechCode sharedPlugin] updataWindowPointX:NSMinX(self.window.frame)];
            return;
        }
        tag = i.name;
        NSString * str = [[JXSpeechCode sharedPlugin]serializationString:i.name];
        [[JXSpeechCode sharedPlugin] speechCaptrueString:str];
        
        __weak typeof (self) ss = self;
        [[JXSpeechCode sharedPlugin] translationString:str completion:^(NSString *results) {
            CGRect rect = [results boundingRectWithSize:NSMakeSize(1000, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[NSFont systemFontOfSize:18]}];
            rect.size.height += 6;
            rect.size.width += 8;
            NSRect newRect;
            newRect.size = rect.size;
            newRect.origin = ss.window.frame.origin;
            newRect.origin.y += ss.window.frame.size.height;
            [[JXSpeechCode sharedPlugin] displayShowWindowWithFrame:newRect stringValue:results];
            
        }];
        
        

    }
}

- (void)jx__hideWindow{
    
    [[JXSpeechCode sharedPlugin] hiddenShowWindow];
    
    [self jx__hideWindow];
   // [JXSpeechCode sharedPlugin].captureText = nil;
}


@end
