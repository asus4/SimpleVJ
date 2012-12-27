//
//  SimpleVJ
//
//  Created by asus4 on 09/11/22.
//


#import "BankKeyPanel.h"


@implementation BankKeyPanel


- (void) keyDown:(NSEvent * ) theEvent
{
	//[super keyDown:theEvent];
	// A~Z 65~90
	// a~z 97~122	
	unichar c = [[theEvent charactersIgnoringModifiers] characterAtIndex:0];
	if(c != 27) // not ESC
	{
		[controller keyDown:theEvent];
	}
}

@end
