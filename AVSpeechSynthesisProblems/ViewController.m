//
//  AVSpeechSynthesisProblems.m
//  AudioVolumeProblems
//
//  Created by MARC W REGAN on 5/15/13.
//  Copyright (c) 2013 MARC W REGAN. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"

@interface ViewController () {
    
    AVSpeechSynthesisVoice* _voice;
    AVSpeechSynthesizer* _synthesizer;
    CGFloat _utteranceRate;
}

@end

#pragma mark -
@implementation ViewController


// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Speech
    _voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    _synthesizer = [[AVSpeechSynthesizer alloc] init];
    _synthesizer.delegate = self;
    _utteranceRate = (AVSpeechUtteranceDefaultSpeechRate + AVSpeechUtteranceMinimumSpeechRate) / 2.0;
}


// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
- (IBAction)play1:(id)sender
{
    NSString* str = @"stay on Concord Avenue for 3 quarters of a mile";
    [self playText:str];
    _textView.text = str;
}


// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
- (IBAction)play2:(id)sender
{
    NSString* str = @"stay on Concord Avenue for 4 quarters of a mile";
    [self playText:str];
    _textView.text = str;
    
}


// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
- (IBAction)play3:(id)sender
{
    NSString* str = @"stay on Cancard Avenue for 3 quarters of a mile";
    [self playText:str];
    _textView.text = str;
    
}


// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
- (void)_setActive {
    UInt32 mix  = 1;
    UInt32 duck = 1;
    NSError* errRet;
    
    AVAudioSession* session = [AVAudioSession sharedInstance];
    [session setActive:NO error:&errRet];
    
    [session setCategory:AVAudioSessionCategoryPlayback error:&errRet];
    NSAssert(errRet == nil, @"setCategory!");
    
    AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryMixWithOthers, sizeof(mix), &mix);
    AudioSessionSetProperty(kAudioSessionProperty_OtherMixableAudioShouldDuck, sizeof(duck), &duck);
    
    [session setActive:YES error:&errRet];
}


// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
- (void) _prepareToPlay {
    [_synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    
    [self _setActive];
}


// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
- (void)_setIdle {
    NSError* errRet;
    
    AVAudioSession* session = [AVAudioSession sharedInstance];
    [session setActive:NO error:&errRet];
    
    [session setCategory:AVAudioSessionCategoryAmbient error:&errRet];
    NSAssert(errRet == nil, @"setCategory!");
    
    [session setActive:YES error:&errRet];
}


// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
-(void)playText:(NSString*)text
{
    [self _prepareToPlay];
    
    AVSpeechUtterance* utterance = [[AVSpeechUtterance alloc] initWithString:text];
    utterance.voice = _voice;
    utterance.rate = _utteranceRate;
    [_synthesizer speakUtterance:utterance];
    
}


#pragma mark - AVSpeechSynthesizer Delegate Methods
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
    [self _setIdle];
}

@end
