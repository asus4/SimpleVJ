//
//  DragDropImageView.h
//  TakeoDesignFes
//
//  Created by ibu on 09/04/12.
//  Copyright 2009 東京芸術大学. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface DragDropImageView : NSImageView {
	NSMutableString *	_filePath;
}

- (NSString *) filePath;

@end
