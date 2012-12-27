//
//  SimpleVJ
//
//  Created by asus4 on 09/11/22.
//


#import "BankKeyImageView.h"


@implementation BankKeyImageView

- (void) awakeFromNib
{
	_filePath = [[NSMutableString alloc] initWithCapacity:1];
}



- (NSString*) filePath
{
	return _filePath;
}


@end


@implementation BankKeyImageView (NSDragging)

- (NSDragOperation) draggingEntered:(id<NSDraggingInfo>)sender
{
	NSPasteboard*			pboard = [sender draggingPasteboard];
	NSArray*				files;
	
	//Check if the dragging pasteboard contains a single file and that we can create a media source from it
	if([pboard availableTypeFromArray:[NSArray arrayWithObject:NSFilenamesPboardType]]) {
		files = [pboard propertyListForType:NSFilenamesPboardType];
		if([files count] == 1) {
			return NSDragOperationCopy;
		}
	}
	
	//[[NSColor selectedControlColor] set];
    //NSFrameRectWidthWidth([self visibleRect], 2.0);
    
	
    	
	
	
	
	return NSDragOperationNone;
}

- (void) draggingEnded:(id<NSDraggingInfo>)sender
{
	//NSLog(@"draggingEnded");
}

- (void) draggingExited:(id<NSDraggingInfo>)sender
{
	//NSLog(@"draggingExited");
}

- (BOOL) prepareForDragOperation:(id<NSDraggingInfo>)sender
{
	//NSLog(@"prepareForDragOperation");
	
	return YES;
}


- (BOOL) performDragOperation:(id<NSDraggingInfo>)sender
{
	NSPasteboard*			pboard = [sender draggingPasteboard];
	
	//Set the media source from the file
	if([pboard availableTypeFromArray:[NSArray arrayWithObject:NSFilenamesPboardType]]) {
		// set file url
		[_filePath setString:[[pboard propertyListForType:NSFilenamesPboardType] objectAtIndex:0]];
		NSLog(_filePath);
		
		return YES;
	}
	
	return NO;
}


- (void) concludeDragOperation:(id<NSDraggingInfo>)sender
{
	// if file can be played with QuickTime.
	if([QTMovie canInitWithFile:_filePath]) {
		NSLog( @"YES movie !!" );
		NSError * error =  nil ;
		QTMovie * movie = [QTMovie movieWithFile:[self filePath]  error: &error];
		[self setImage:[movie currentFrameImage]];
		
	} else {
		NSLog( @"movie NO" ) ; 
	}
	
	NSLog(@"dropd tag is %d", [self tag]);
}




@end
