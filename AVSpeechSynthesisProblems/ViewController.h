//
//  AVSpeechSynthesisProblems.h
//  AudioVolumeProblems
//
//  Created by MARC W REGAN on 5/15/13.
//  Copyright (c) 2013 MARC W REGAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <AVAudioPlayerDelegate, AVSpeechSynthesizerDelegate>
@property (strong, nonatomic) IBOutlet UITextView *textView;
- (IBAction)play1:(id)sender;
- (IBAction)play2:(id)sender;
- (IBAction)play3:(id)sender;

@end
