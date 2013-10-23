//
//  BpmCounter.m
//  SimpleVJ
//
//  Created by ibu on 2013/10/23.
//
//

#import "BpmCounter.h"

@implementation BpmCounter

const float _MIN_INTERVAL = 0.05f;
const float _MAX_INTERVAL = 5.0f;


- (id) initWithBpmLabel:(NSTextField*) label meter:(NSLevelIndicator *)meter listener:(id<BpmCounterProtcol>) listener {
    if (self = [super init]) {
        bpmLabel = label;
        beatMeter = meter;
        bpm = 120.0f;
        count = 0;
        autoSwitch = NO;
        delegate = listener;
        
        last_update = [NSDate date];
        [last_update retain];
        
        [self loop:nil];
    }
    return self;
}

- (void) update {
    autoSwitch = NO;
    
    NSDate *now = [NSDate date];
    bpm = [self timeInterbalToBpm:[now timeIntervalSinceDate:last_update]];
    last_update = [now retain];
    
    [bpmLabel setStringValue:[NSString stringWithFormat:@"%f", bpm]];
}

- (void) autoSwitch:(BOOL) doAuto {
    autoSwitch = doAuto;
}


- (void) loop:(NSDictionary*)param{
    
    // update count
    if(count > 3) {
        count=0;
    }
    [beatMeter setFloatValue:count+1];
    count++;
    
    NSTimeInterval delay = [self bpmToTimeInterbal:bpm];
    [bpmLabel setStringValue:[NSString stringWithFormat:@"%f", bpm]];
    
    
    if(delay  < _MIN_INTERVAL) {
        delay = _MIN_INTERVAL;
        bpm = [self timeInterbalToBpm:delay];
    }
    else if(delay > _MAX_INTERVAL) {
        delay = _MAX_INTERVAL;
        bpm = [self timeInterbalToBpm:delay];
    }
    
    if(autoSwitch) {
        [delegate autoFade];
    }
    
    [self performSelector:@selector(loop:) withObject:nil afterDelay:delay];
}

- (NSTimeInterval) bpmToTimeInterbal:(float)_bpm {
    return 60.0 / _bpm;
}

- (float) timeInterbalToBpm:(NSTimeInterval)_interval {
    return 60.0f / _interval;
}

@end
