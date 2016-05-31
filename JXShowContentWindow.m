//
//  JXShowContentWindow.m
//  WindowTest
//
//  Created by dfxd on 16/5/26.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import "JXShowContentWindow.h"

@implementation JXShowContentWindow
{
    NSTextField * _textField;
    
}

- (instancetype)initWithContentRect:(NSRect)contentRect{
    self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
    if (self) {
        self.alphaValue = 0;
        _textField                  = [NSTextField new];
        _textField.backgroundColor  = [NSColor yellowColor];
        _textField.editable         = NO;
        _textField.bordered         = YES;
        _textField.textColor        = [NSColor blackColor];
        _textField.font             = [NSFont systemFontOfSize:18.0f];
        self.contentView            = _textField;
        
    }
    
    return self;
}



- (void)setText:(NSString *)text{
    _textField.stringValue = text;
    _text = text;
    
}

- (void)showWindowWithFrame:(NSRect)rect{
    
    [self setFrame:rect display:YES];
    [[NSApp keyWindow] addChildWindow:self ordered:NSWindowAbove];
    [self.animator setAlphaValue:1];
}



- (void)hidden{
    [self.animator setAlphaValue:0];
    _text = @"";
    _textField.stringValue = @"";
    [self orderOut:nil];
    
}



@end
