//
//  BankKeyImageView.h
//  SimpleVJ
//
//  Created by ibu on 09/11/22.
//  Copyright 2009 東京芸術大学. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QTKit/QTKit.h>


@interface BankKeyImageView : NSImageView {
	NSMutableString *	_filePath;
}

- (NSString *) filePath;

@end
