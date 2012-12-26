//
//  BankKeyDelegate.h
//  SimpleVJ
//
//  Created by ibu on 09/11/23.
//  Copyright 2009 東京芸術大学. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface BankKeyDelegate : NSObject {
	IBOutlet NSWindow *window;
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSManagedObjectContext *)managedObjectContext;

- (IBAction)saveAction:sender;

@end
