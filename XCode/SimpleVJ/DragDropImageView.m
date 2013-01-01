//
//  SimpleVJ
//
//  Created by asus4 on 09/11/22.
//


#import "DragDropImageView.h"


@implementation DragDropImageView

- (void) awakeFromNib
{
	_filePath = [[NSMutableString alloc] initWithCapacity:1];
	NSLog(@"ccaled   Dragagadnga");
	NSLog([[self target] className]);
	NSLog(@"tag is %d", [self tag]);
}



- (NSString*) filePath
{
	return _filePath;
}

@end


@implementation DragDropImageView (NSDragging)

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
	
	return NSDragOperationNone;
}

- (void) draggingEnded:(id<NSDraggingInfo>)sender
{
	NSLog(@"draggingEnded");
}

- (void) draggingExited:(id<NSDraggingInfo>)sender
{
	NSLog(@"draggingExited");
}

- (BOOL) prepareForDragOperation:(id<NSDraggingInfo>)sender
{
	NSLog(@"prepareForDragOperation");

	return YES;
}

- (BOOL) performDragOperation:(id<NSDraggingInfo>)sender
{
	NSPasteboard*			pboard = [sender draggingPasteboard];
	
	//Set the media source from the file
	if([pboard availableTypeFromArray:[NSArray arrayWithObject:NSFilenamesPboardType]]) {
		
		[_filePath setString:[[pboard propertyListForType:NSFilenamesPboardType] objectAtIndex:0]];
		//NSLog(_filePath);
		return YES;
	}
	
	return NO;
}


- (void) concludeDragOperation:(id<NSDraggingInfo>)sender
{
	// send Action !!!!!
	if([self tag] == 0) {
		[self sendAction:@selector(changePathA:) to:[self target]];
	} else {
		[self sendAction:@selector(changePathB:) to:[self target]];
	}
	//NSLog(@"concludeDragOperation");
}


@end
