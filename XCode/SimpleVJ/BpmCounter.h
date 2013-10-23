//
//  BpmCounter.h
//  SimpleVJ
//
//  Created by ibu on 2013/10/23.
//
//

#import <Foundation/Foundation.h>

@protocol BpmCounterProtcol
- (void) autoFade;
@end

@interface BpmCounter : NSObject {
    NSTextField * bpmLabel;
    NSLevelIndicator * beatMeter;
    float bpm;
    int count;
    id <BpmCounterProtcol> delegate;
    BOOL autoSwitch;
    NSDate *last_update;
}

- (id) initWithBpmLabel:(NSTextField*) label meter:(NSLevelIndicator *)meter listener:(id<BpmCounterProtcol>) listener;
- (void) update;
- (void) autoSwitch:(BOOL) doAuto;
@end
