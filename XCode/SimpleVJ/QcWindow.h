//
//  SimpleVJ
//
//  Created by asus4 on 09/03/30.
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
