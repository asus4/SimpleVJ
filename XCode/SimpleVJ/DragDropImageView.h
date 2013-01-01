//
//  SimpleVJ
//
//  Created by asus4 on 09/11/22.
//


#import <Cocoa/Cocoa.h>


@interface DragDropImageView : NSImageView {
	NSMutableString *	_filePath;
}

- (NSString *) filePath;

@end
