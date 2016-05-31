//
//  PrivateClass.h
//  JXSpeechCode
//
//  Created by dfxd on 16/5/26.
//  Copyright © 2016年 dfxd. All rights reserved.
//
#import <Cocoa/Cocoa.h>




@interface DVTCompletingTextView :NSTextView

- (BOOL)selectFirstPlaceholderInCharacterRange:(struct _NSRange)arg1;

@end
//DVTTextCompletionListWindowController
@interface DVTTextCompletionListWindowController : NSWindowController<NSTableViewDelegate,NSTableViewDataSource>


- (void)showWindowForTextFrame:(struct CGRect)arg1 explicitAnimation:(BOOL)arg2;


- (id)_selectedCompletionItem;
- (void)showInfoPaneForCompletionItem:(id)arg1;
- (void)_hideWindow;


@end


@interface IDEIndexCompletionItem : NSObject
{
    NSString *_name;
}
@property(readonly) NSString *name;


@end

