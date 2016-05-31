//
//  JXShowContentWindow.h
//  WindowTest
//
//  Created by dfxd on 16/5/26.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface JXShowContentWindow : NSWindow
@property(nonatomic,copy)NSString * text;

- (instancetype)initWithContentRect:(NSRect)contentRect;
- (void)showWindowWithFrame:(NSRect)rect;
- (void)hidden;

@end
