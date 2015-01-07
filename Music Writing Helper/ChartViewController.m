//
//  ChartViewController.m
//  Music Writing Helper
//
//  Created by Michael Reiter on 2014-11-14.
//  Copyright (c) 2014 Michael Reiter. All rights reserved.
//

#import "ChartViewController.h"
#import "SVGKImage.h"
#import "SVGKFastImageView.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:self.color];
    
    int fontSize, iconSize, chartSize, chordLabelXPosition, chordLabelYPosition, playButtonXPosition, playButtonYPosition;
    
    if (self.view.frame.size.width < 330){          //iPhone 4S, 5, 5S
        fontSize = 20;
        iconSize = 40;
        chartSize = 242;
        chordLabelXPosition = self.view.frame.size.width/5.5;
        chordLabelYPosition = self.view.frame.size.height/10;
        playButtonXPosition = self.view.frame.size.width*.59;
        playButtonYPosition = self.view.frame.size.height/10 - 35;
    } else if (self.view.frame.size.width < 380){   //iPhone 6
        fontSize = 23;
        iconSize = 50;
        chartSize = 260;
        chordLabelXPosition = self.view.frame.size.width/5;
        chordLabelYPosition = self.view.frame.size.height/9;
        playButtonXPosition = self.view.frame.size.width*.59;
        playButtonYPosition = self.view.frame.size.height/16;
    } else if (self.view.frame.size.width < 420){   //iPhone 6 Plus
        fontSize = 28;
        iconSize = 60;
        chartSize = 300;
        chordLabelXPosition = self.view.frame.size.width/5;
        chordLabelYPosition = self.view.frame.size.height/8.2;
        playButtonXPosition = self.view.frame.size.width*.61;
        playButtonYPosition = self.view.frame.size.height/13;
    } else {                                        //iPad
        fontSize = 35;
        iconSize = 80;
        chartSize = 400;
        chordLabelXPosition = self.view.frame.size.width/5;
        chordLabelYPosition = self.view.frame.size.height/7;
        playButtonXPosition = self.view.frame.size.width*.68;
        playButtonYPosition = self.view.frame.size.height/9;
    }

    //create chord label
    UILabel *chordLabel = [[UILabel alloc] initWithFrame:CGRectMake(chordLabelXPosition, chordLabelYPosition, 120, 30)];
    chordLabel.textColor = [UIColor whiteColor];
    chordLabel.backgroundColor = [UIColor clearColor];
    chordLabel.text = self.chord;
    chordLabel.font = [UIFont fontWithName:@"Quicksand-Bold" size:fontSize];
    [self.view addSubview:chordLabel];
    
    //Create play button
    UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(playButtonXPosition, playButtonYPosition, 100, 100)];
    [playButton addTarget:self
                   action:@selector(playPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    SVGKImage *play = [SVGKImage imageNamed:@"play-button.svg"];
    play.size = CGSizeMake(iconSize, iconSize);
    UIImage *playIcon = [[UIImage alloc] init];
    playIcon = play.UIImage;
    [playButton setImage:playIcon forState:UIControlStateNormal];
    [playButton setImage:playIcon forState:UIControlStateHighlighted];
    [self.view addSubview:playButton];
    
    //Creat SVG chord chart
    NSString *chordChartFilename = [NSString stringWithFormat:@"%@.svg", self.chord];
    SVGKImage *chart = [SVGKImage imageNamed:chordChartFilename];
    chart.size = CGSizeMake(chartSize, chartSize);
    SVGKFastImageView *SVGView = [[SVGKFastImageView alloc] initWithSVGKImage:chart];
    SVGView.frame = CGRectMake((self.view.frame.size.width/2) - (chart.size.width/2), (self.view.frame.size.height/2) - (chart.size.height/2), chart.size.width, chart.size.height);
    [self.view addSubview:SVGView];
}

- (void)playPressed:(UIButton *)sender
{
    SystemSoundID soundID;
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", self.chord] ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) url, &soundID);
    AudioServicesPlaySystemSound(soundID);
    
    /*
    NSError *error;
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", self.chord] ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
     */
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end

/*
 SVGKit License:
 Copyright (c) 2010-2011 Matt Rajca
 Parts Copyright (c) Tipbit Inc
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */