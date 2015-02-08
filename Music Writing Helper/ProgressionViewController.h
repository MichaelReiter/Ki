//
//  ProgressionViewController.h
//  Music Writing Helper
//
//  Created by Michael Reiter on 2014-11-15.
//  Copyright (c) 2014 Michael Reiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSArray+Key.h"
#import <AVFoundation/AVFoundation.h>

@interface ProgressionViewController : UIViewController

@property int numberOfChords;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSArray *chords;
@property (strong, nonatomic) NSMutableArray *progression;
@property UIColor *initialColor;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) UIButton *playButton;
@property int playCounter;

- (void)chordPressed:(id)sender;

- (void)dispatch;

@end
