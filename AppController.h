//
//  AppController.h
//  TakeoDesignFes
//
//  Created by ibu on 09/03/24.
//  Copyright Koki Ibukuro 2009 . All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import "DragDropImageView.h"

@interface AppController : NSResponder//NSObject 
{
	IBOutlet NSWindow* qcWindow;	// フルスクリーンになるやつ
    IBOutlet QCView* qcView;		//
	IBOutlet NSSlider* fader;		// 手動のフェーダー
	//IBOutlet NSSlider* fadeTime;	// フェード時間のつまみ
	IBOutlet NSSegmentedControl* fadeTimeSegment; // フェード時間をデフォルトで選べるつまみ。
	
	IBOutlet NSSlider* positionA;	// ムービー再生位置
	IBOutlet NSSlider* positionB;
	IBOutlet NSButton* isPauseA;	// 一時停止トグルボタン
	IBOutlet NSButton* isPauseB;
	IBOutlet NSButton* isLoopA;		// ループトグルボタン
	IBOutlet NSButton* isLoopB;
	IBOutlet NSImageView* previewA;	// プレビューウィンドウ
	IBOutlet NSImageView* previewB;
	
	NSPoint _initialLocation; // マウス座標。
	BOOL	_isFullscreen;
	BOOL	_isFadeThreading;
	
	float autofadetime;
	
	NSMutableString * _pathA;
	NSMutableString * _pathB;
	//BOOL	_loopA, _loopB;
	//BOOL	_pauseA, _pauseB;
	//float	_timeA, _timeB;
	//float	_durationA, _durationB;
	
}

- (IBAction) changePathA:(id)sender;			// パスA
- (IBAction) changePathB:(id)sender;			// パスB
- (IBAction) changePositionA:(NSSlider*)sender;	// Aのポジション変更
- (IBAction) changePositionB:(NSSlider*)sender; // Bの~
- (IBAction) changePauseA:(NSButton*)sender;	// ポーズ　（トグルボタン）
- (IBAction) changePauseB:(NSButton*)sender;
- (IBAction) changeLoopA:(NSButton*)sender;		// ループ　（トグルボタン）
- (IBAction) changeLoopB:(NSButton*)sender;


- (IBAction) changeFade:(NSSlider*)sender;				// フェーダー(スライダー)かわる
- (IBAction) changeFadeSpeed:(NSSlider*)sender;			// 自動フェードのフェードタイムを変える。
														//けど、いまのところなんもしない。
- (IBAction) autoFade:(NSButton*)sender;				// 自動的にフェード

- (void) autoFade;


- (IBAction) goFullscreen:(id)sender;			// フルスクリーン or 解除。
- (void) enterFullscreen;								// フルスクリーンにする
- (void) exitFullscreen;								// フルスクリーン解除
- (void) fadeThread;	// プライベート関数
//- (void) posSliderTimerFunc:(NSTimer *) posSliderTimer;
- (void) previewImageLoop: (NSTimer *) previewTimer;


// ユーティリティー関数群。
- (float) getQcPatchTime;
- (float) getQcDurationA;
- (float) getQcDurationB;
- (float) getQcPositionA;
- (float) getQcPositionB;
- (void) setQcTimeA:(float) time;
- (void) setQcTimeB:(float) time;
//- (float) moduro:(float)left by:(float)right;

@end