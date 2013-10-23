//
//  AppController.m
//  SimpleVJ
//
//  Created by asus4 on 09/03/24.
//

#import "AppController.h"


@implementation AppController
 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// イニシャライズ
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- (void) awakeFromNib
{
	if(![qcView loadCompositionFromFile:[[NSBundle mainBundle] pathForResource:@"player" ofType:@"qtz"]]) {
		NSLog(@"Could not load composition");
	}
	
	_isFullscreen = NO;
	_isFadeThreading = NO;
	autofadetime = 1.0;
	[fadeTimeSegment setSelected:YES forSegment:2];
	
	
	// タイマー　posSliderTimerFuncを同じスレッドで、繰り返し実行。
	NSTimer * previewTimer;
	previewTimer = [ NSTimer scheduledTimerWithTimeInterval:0.5
													 target:self
												   selector:@selector(previewImageLoop:) 
												   userInfo:nil 
													repeats:YES ];
	
	[[ NSRunLoop currentRunLoop ] addTimer: previewTimer forMode:NSEventTrackingRunLoopMode ];
	
	_pathA = [[NSMutableString alloc] initWithCapacity:1];
	_pathB = [[NSMutableString alloc] initWithCapacity:1];
    
    
    NSLog(@"fasdfasdaslkd");
    NSLog(@"fawfa %@ %@", previewA, bpmMeter);
    bpmCounter = [[BpmCounter alloc] initWithBpmLabel:bpmLabel meter:bpmMeter listener:self];
//    [bpmCounter start];
}

- (void)windowWillClose:(NSNotification *)notification 
{
	[_pathA release], _pathA = nil;
	[_pathB release], _pathB = nil;

	[NSApp terminate:self];
}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// イベント関係
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


// QC_Windowからのイベント
- (void) keyDown:(NSEvent *)event
{
	unichar c = [[event charactersIgnoringModifiers] characterAtIndex:0];
	switch (c) {
		// [Esc] exit fullscreen mode.
		case 27:
			[self exitFullscreen]; break;
		case 32: // case SPACE 
			[self autoFade];
		default:
			break;
	}
	
}




//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ムービー再生関係のアクション
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- (IBAction) changePathA:(id)sender
{
	NSString * filePath;
	if([sender isKindOfClass:[DragDropImageView class]]) {
		// DragDropImageView(オリジナル)からのアクション
		filePath = [[NSString alloc] initWithString:[sender filePath]];
	}
	
	if([_pathA compare:filePath] != NSOrderedSame) { // movie changed
		[qcView setValue:filePath forInputKey:@"pathA"];
		[self setQcTimeA:0.0f];
		[positionA setFloatValue:0.0f];
		//[isPauseA setState:NSOnState];
		//[qcView setValue:[NSNumber numberWithInt:NSOnState] forInputKey:@"isPauseA"];
	}
	[_pathA setString: filePath];
	[filePath release];
	
	// reset timescale
	[self setQcTimeScaleA:1.0f];
	[timescaleA setFloatValue:1.0f];
}

- (IBAction) changePathB:(id)sender
{
	NSString * filePath;
	if([sender isKindOfClass:[DragDropImageView class]]) {
		filePath = [[NSString alloc] initWithString:[sender filePath]];
	}
	if([_pathB compare:filePath] != NSOrderedSame) { // movie changed
		[qcView setValue:filePath forInputKey:@"pathB"];
		[self setQcTimeB:0.0f];
		[positionB setFloatValue:0.0f];
		//[isPauseB setState:NSOnState];
		//[qcView setValue:[NSNumber numberWithInt:NSOnState] forInputKey:@"isPauseB"];
	}
	[_pathB setString: filePath];
	[filePath release];
	
	// reset timescale
	[self setQcTimeScaleA:1.0f];
	[timescaleA setFloatValue:1.0f];
}

- (IBAction) changePositionA:(NSSlider*)sender
{
	if([isPauseA state] == NSOffState) { // movie is playing
		[self setQcTimeA:([sender floatValue]*[self getQcDurationA])];
	} else {
		float time = [sender floatValue]*[self getQcDurationA];
		[qcView setValue:[NSNumber numberWithFloat:time] forInputKey:@"timeA"];
	}
}

- (IBAction) changePositionB:(NSSlider*)sender
{
	if([isPauseB state] == NSOffState) {
		[self setQcTimeB:([sender floatValue]*[self getQcDurationB])];	
	} else {
		float time = [sender floatValue]*[self getQcDurationB];
		[qcView setValue:[NSNumber numberWithFloat:time] forInputKey:@"timeB"];
	}
}

- (IBAction) changePauseA:(NSButton*)sender
{
	if ([sender state] == NSOnState) {
		float time = [self getQcPositionA];
		[qcView setValue:[NSNumber numberWithFloat:time] forInputKey:@"timeA"];
	} else {
		[self setQcTimeA:[self getQcPositionA]];	
	}
	[qcView setValue:[NSNumber numberWithInt:[sender state]] forInputKey:@"isPauseA"];
}

- (IBAction) changePauseB:(NSButton*)sender
{
	if([sender state] == NSOnState) {
		float time = [self getQcPositionB];
		[qcView setValue:[NSNumber numberWithFloat:time] forInputKey:@"timeB"];
	} else {
		[self setQcTimeB:[self getQcPositionB]];
	}
	[qcView setValue:[NSNumber numberWithInt:[sender state]] forInputKey:@"isPauseB"];
}

- (IBAction) changeLoopA:(NSButton*)sender
{
	[qcView setValue:[NSNumber numberWithInt:[sender state]] forInputKey:@"isLoopA"];
	if ([sender state] == NSOffState) {
		[self setQcTimeA:[self getQcPositionA]];	
	}
}

- (IBAction) changeLoopB:(NSButton*)sender
{
	[qcView setValue:[NSNumber numberWithInt:[sender state]] forInputKey:@"isLoopB"];
	if([sender state] == NSOffState) {
		[self setQcTimeB:[self getQcPositionB]];
	}
}

- (IBAction) changeTimeScaleA:(NSSlider*)sender
{
	[self setQcTimeScaleA:[sender floatValue]];
}

- (IBAction) changeTimeScaleB:(NSSlider*)sender
{
	[self setQcTimeScaleB:[sender floatValue]];
}



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// フェーダー関係のアクション
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- (IBAction) changeFade:(NSSlider*)sender
{
	[qcView setValue:[NSNumber numberWithFloat:[sender floatValue]] forInputKey:@"fade"];
	//NSLog(@"%%f = %f" ,[sender floatValue]);
}

- (IBAction) changeFadeSpeed:(NSSlider*)sender
{
	// なんもしないよ。
}

- (IBAction)toggleAutoFade:(id)sender {
    if(isAutoSwitch.state == NSOnState) {
        [isAutoSwitch setState:NSOffState];
    }
    else {
        [isAutoSwitch setState:NSOnState];
    }
    [self clickAutoSwitch:isAutoSwitch];
}

- (IBAction) autoFade:(NSButton*)sender
{
    [isAutoSwitch setState:NSOffState];
    [bpmCounter update];
	[self autoFade];
}


- (IBAction)clickAutoSwitch:(NSButton *)sender {
    if(sender.state == NSOnState) {
        [bpmCounter autoSwitch:YES];
    }
    else {
        [bpmCounter autoSwitch:NO];
    }
}

- (void) autoFade
{
	if(_isFadeThreading) {
		_isFadeThreading = NO;
	} else {
		[NSThread detachNewThreadSelector:@selector(fadeThread) toTarget:self withObject:nil];
	}
}
			


- (IBAction) goFullscreen:(id)sender
{
	NSLog(@"fulllscreeeen");
	if(_isFullscreen) {
		[self exitFullscreen];
	} else {
		[self enterFullscreen];
	}
}



- (void) enterFullscreen
{
	[ qcWindow setFrame: [ [[NSScreen screens] lastObject] frame ] display:YES];
	//ディスプレイサイズにwindowをセットする。
	[ qcWindow orderFront: self ];
	//windowを最前面にする
	_isFullscreen = YES;
}
	

- (void) exitFullscreen
{
	[ qcWindow setFrame:NSMakeRect( 30.0f, 30.0f, 640.0f, 480.0f ) display:YES];
	_isFullscreen = NO;
}



// フェーダーが自動的に動くスレッド。
- (void) fadeThread
{	
	_isFadeThreading = YES;
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	float waitTime = autofadetime / 100;
	float originVal = [fader floatValue];
	float val;
	int i;
	for(i=0; i<100; i++){
		if(!_isFadeThreading) break;

		//[NSThread sleepForTimeInterval:waitTime];
		[NSThread sleepUntilDate: [NSDate dateWithTimeIntervalSinceNow:waitTime]];
		if( originVal > 0.5) {
			val = [fader floatValue] - originVal/100.0;
		} else {
			val = [fader floatValue] + (1-originVal)/100.0;
		}
		[fader setFloatValue: val];
		[qcView setValue:[NSNumber numberWithFloat:val] forInputKey:@"fade"];
		//NSLog(@"%f",val);
	}
	_isFadeThreading = NO;
	[pool release];
	[NSThread exit];

}



// 0.5秒毎に実行するタイマー関数。
// プレビューと再生ポジションを更新。
- (void) previewImageLoop: (NSTimer *) previewTimer
{
	[previewA setImage: [qcView valueForOutputKey:@"imageOutA"]];
	[previewB setImage: [qcView valueForOutputKey:@"imageOutB"]];
	float time; // 0.0 ~ 1.0 の範囲に変換する。
	time = [[qcView valueForOutputKey:@"moviePositionA"] floatValue] /  [[qcView valueForOutputKey:@"movieDurationA"] floatValue];
	[positionA setFloatValue:time ];
	time = [[qcView valueForOutputKey:@"moviePositionB"] floatValue] /  [[qcView valueForOutputKey:@"movieDurationB"] floatValue];
	[positionB setFloatValue:time ];
}



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ユーティリティー関数群
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (float) getQcPatchTime {
	return [[qcView valueForOutputKey:@"patchTime"] floatValue];	
}
- (float) getQcDurationA {
	return [[qcView valueForOutputKey:@"movieDurationA"] floatValue];
}	
- (float) getQcDurationB {
	return [[qcView valueForOutputKey:@"movieDurationB"] floatValue];
}
- (float) getQcPositionA {
	return [[qcView valueForOutputKey:@"moviePositionA"] floatValue];
}
- (float) getQcPositionB {
	return [[qcView valueForOutputKey:@"moviePositionB"] floatValue];
}
- (void) setQcTimeA:(float) time {
	time -= [self getQcPatchTime];
	[qcView setValue:[NSNumber numberWithFloat:time] forInputKey:@"timeA"];
}
- (void) setQcTimeB:(float) time {
	time -= [self getQcPatchTime];
	[qcView setValue:[NSNumber numberWithFloat:time] forInputKey:@"timeB"];
}

- (void) setQcTimeScaleA:(float) time
{
	[qcView setValue:[NSNumber numberWithFloat:time] forInputKey:@"timescaleA"];
}

- (void) setQcTimeScaleB:(float) time
{
	[qcView setValue:[NSNumber numberWithFloat:time] forInputKey:@"timescaleB"];
}




@end
