//
//  QcWindow.h
//  TakeoDesignFes
//
//  Created by ibu on 09/03/30.
//  Copyright 2009 東京芸術大学. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface QcWindow : NSWindow {
	IBOutlet NSResponder *controller;
	
	NSPoint _initialLocation; // マウス座標。
}
@end



@interface PlayerView : NSView
{

}
@end
