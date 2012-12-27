//
//  SimpleVJ
//
//  Created by asus4 on 09/09/07.
//


#import "MixerWindow.h"


@implementation MixerWindow

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
    // Drawing code here.
}

- (void) keyDown:(NSEvent * ) theEvent
{
	[controller keyDown:theEvent];
}

@end
