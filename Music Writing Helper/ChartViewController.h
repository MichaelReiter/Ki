//
//  ChartViewController.h
//  Music Writing Helper
//
//  Created by Michael Reiter on 2014-11-14.
//  Copyright (c) 2014 Michael Reiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVGKImage.h"
#import <AVFoundation/AVFoundation.h>

@interface ChartViewController : UIViewController

@property UIColor *color;
@property (strong, nonatomic) NSString *chord;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

- (void)playPressed:(UIButton *)sender;

@end
