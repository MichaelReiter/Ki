//
//  ProgressionViewController.m
//  Music Writing Helper
//
//  Created by Michael Reiter on 2014-11-15.
//  Copyright (c) 2014 Michael Reiter. All rights reserved.
//

#import "ProgressionViewController.h"
#import "ChartViewController.h"
#import "NSArray+Key.h"
#import "SVGKImage.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@implementation ProgressionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.playCounter = 0;
    
    //enable swipe to go back gesture
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedBack)];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeGestureRecognizer];
    
    int fontSize, iconSize;
    int widthOfButton = self.view.frame.size.width/2;
    
    if (self.view.frame.size.width < 330){          //iPhone 4S, 5, 5S
        fontSize = 20;
        iconSize = 40;
    } else if (self.view.frame.size.width < 380){   //iPhone 6
        fontSize = 23;
        iconSize = 50;
        widthOfButton += 1;
    } else if (self.view.frame.size.width < 420){   //iPhone 6 Plus
        fontSize = 28;
        iconSize = 60;
    } else {                                        //iPad
        fontSize = 35;
        iconSize = 80;
    }
    
    CGFloat hue, saturation, brightness, alpha, bgHue, bgSaturation, bgBrightness, bgAlpha;
    [self.initialColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    [self.initialColor getHue:&bgHue saturation:&bgSaturation brightness:&bgBrightness alpha:&bgAlpha];
    
    int k, x, divisor, heightOfButton;
    int y = 0;
    
    self.progression = [self.chords randomProgression:self.chords Chords:@(self.numberOfChords)];
    
    if (self.progression.count % 2 == 0) {
        divisor = (int)self.progression.count/2;
    } else {
        divisor = ((int)self.progression.count + 1) / 2;
        
        //fill empty space with darkened color
        UIColor *backgroundColor = [[UIColor alloc] initWithHue:bgHue saturation:bgSaturation brightness:bgBrightness alpha:bgAlpha];
        [self.view setBackgroundColor:backgroundColor];
    }
    
    heightOfButton = self.view.frame.size.height/divisor + 0.75;
    
    //lighten and desaturate progression buttons' color back to as they were in the list of chords
    for (k = 0; k < self.progression.count; k++){
        brightness /= 0.97;
        saturation /= 1.03;
    }

    for (k = 0; k < self.progression.count; k++){
        
        //alternate x position
        if (k % 2 == 0){
            x = 0;
        } else {
            x = self.view.frame.size.width/2;
        }
        
        //increase y position
        if (k > 1){
            if (k % 2 == 0){
                y += heightOfButton;
            }
        }
        
        //Create chord buttons
        UIColor *color = [[UIColor alloc] initWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, widthOfButton, heightOfButton)];
        [button addTarget:self
                   action:@selector(chordPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[NSString stringWithFormat:@"%@", self.progression[k]]
                forState:UIControlStateNormal];
        [button setBackgroundColor:color];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"Quicksand-Bold" size:fontSize];
        [self.view addSubview:button];
        
        //change color brightness
        brightness *= 0.97;
        saturation *= 1.03;
    }
    
    //Create play button
    self.playButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 - 50, 100, 100)];
    [self.playButton addTarget:self
                   action:@selector(dispatch)
         forControlEvents:UIControlEventTouchUpInside];
    SVGKImage *play = [SVGKImage imageNamed:@"play-button.svg"];
    play.size = CGSizeMake(iconSize, iconSize);
    UIImage *playIcon = play.UIImage;
    [self.playButton setImage:playIcon forState:UIControlStateNormal];
    [self.playButton setImage:playIcon forState:UIControlStateHighlighted];
    [self.view addSubview:self.playButton];
}

- (void)dispatch
{
    //send the playPressed message on the global queue so the sound can be played while the UI is upadated
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{[self playPressed:self.playButton];});
}

- (void)playPressed:(UIButton *)sender
{
    NSError *error;
    NSString *path;
    NSURL *url;
    if (![self.audioPlayer isPlaying] && self.playCounter == 0){
        while (self.playCounter < self.progression.count){
            if (![self.audioPlayer isPlaying]){
                path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", [self.progression objectAtIndex:self.playCounter]] ofType:@"wav"];
                url = [NSURL fileURLWithPath:path];
                self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
                [self.audioPlayer prepareToPlay];
                [self.audioPlayer play];
                self.playCounter++;
            }
        }
        self.playCounter = 0;
    }
}

- (void)chordPressed:(UIButton *)sender
{
    ChartViewController *chartVC = [[ChartViewController alloc] initWithNibName:nil bundle:nil];
    chartVC.color = sender.backgroundColor;
    chartVC.chord = sender.titleLabel.text;
    [self.navigationController pushViewController:chartVC animated:YES];
}

- (void)swipedBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
