//
//  QcWindow.m
//  TakeoDesignFes
//
//  Created by ibu on 09/03/30.
//  Copyright 2009 koki ibukuro. All rights reserved.
//

#import "QcWindow.h"


@implementation QcWindow
- (id) initWithContentRect : (NSRect) contentRect
				 styleMask : (unsigned int) aStyle //windowスタイル
				   backing : (NSBackingStoreType) bufferingType
					 defer : (BOOL) flag
{
	
	/// INITIALIZE BY SUPER CLASS
	NSWindow* winFull = [ super initWithContentRect : contentRect
										  styleMask :NSBorderlessWindowMask//ボーダーなし
											backing : bufferingType
											  defer : NO ];
	[ winFull setLevel : kCGScreenSaverWindowLevel ];	// 最前面に。

	
	return winFull;//winFullをかえす
}

- (void) awakeFromNib
{
//	[NSCursor hide];
}

- (BOOL) canBecomeKeyWindow
{
    return YES;
}

- (BOOL) acceptsFirstResponder
{
	return  YES ;
}



// キーを押したら 
- (void) keyDown:(NSEvent *) theEvent
{
	[controller keyDown:theEvent];
}

- (void) mouseDragged:(NSEvent *)theEvent
{
	
	NSPoint current_mouse;
	NSPoint neworigin_mouse;
	
	// グローバルマウス座標を得る
	current_mouse = [self convertBaseToScreen:[self mouseLocationOutsideOfEventStream ]];
	neworigin_mouse.x = current_mouse.x - _initialLocation.x;
	neworigin_mouse.y = current_mouse.y - _initialLocation.y;
	[ self setFrameOrigin:neworigin_mouse ];
	
	//NSLog(@"dragged");
}

- (void) mouseDown:(NSEvent *) theEvent
{
	_initialLocation = [theEvent locationInWindow];
}


@end







@implementation PlayerView
- (void)resetCursorRects
{
    NSRect rect = [self bounds];
    NSCursor* cursor = [NSCursor IBeamCursor];
    [self addCursorRect:rect cursor:cursor];
	
	//NSTrackingArea * tArea = [NSTrackingArea initWithRect:rect op
//	[self addTrackingRect:rect owner:self userData:nil assumeInside:NO];
//	NSLog(@"load rects");
	
}

/*
- (void) mouseEnterd:(NSEvent *) theEvent
{
	[NSCursor hide];
	NSLog(@"mouse entersss");
}

- (void) mouseExited:(NSEvent *) theEvent
{
	NSLog(@"mouse Exitedd");
	[NSCursor unhide];
}
 */



@end
 

