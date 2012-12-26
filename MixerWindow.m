//
//  MixerWindow.m
//  SimpleVJ
//
//  Created by ibu on 09/09/07.
//  Copyright 2009 東京芸術大学. All rights reserved.
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
