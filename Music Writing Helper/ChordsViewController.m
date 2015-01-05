//
//  ChordsViewController.m
//  Music Writing Helper
//
//  Created by Michael Reiter on 2014-11-10.
//  Copyright (c) 2014 Michael Reiter. All rights reserved.
//

#import "ChordsViewController.h"
#import "KeyViewController.h"
#import "ChartViewController.h"
#import "RandomizerViewController.h"
#import "SVGKImage.h"

@implementation ChordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //enable swipe back gesture
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    UIColor *initialColor = [[UIColor alloc] initWithHue:self.hue saturation:self.saturation brightness:self.brightness alpha:1];
    
    int k, x, fontSize, randomXSize, randomYSize;
    int y = 0;
    int width = self.view.frame.size.width/2;
    int height = self.view.frame.size.height/4 + 0.25;
    
    if (self.view.frame.size.width < 330){          //iPhone 4S, 5, 5S
        fontSize = 20;
        randomXSize = 26;
        randomYSize = 17;
    } else if (self.view.frame.size.width < 380){   //iPhone 6
        fontSize = 23;
        randomXSize = 28;
        randomYSize = 19;
        width += 1; //correct box sizing
    } else if (self.view.frame.size.width < 420){   //iPhone 6 Plus
        fontSize = 28;
        randomXSize = 35;
        randomYSize = 22;
    } else {                                        //iPad
        fontSize = 35;
        randomXSize = 45;
        randomYSize = 30;
    }
    
    for (k = 0; k < self.chords.count; k++){
        
        //alternate x position
        if (k % 2 == 0){
            x = 0;
        } else {
            x = width;
        }
        
        //increase y position
        if (k > 1){
            if (k % 2 == 0){
                y += height;
            }
        }
        
        //Create chord buttons
        UIColor *color = [[UIColor alloc] initWithHue:self.hue saturation:self.saturation brightness:self.brightness alpha:1];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [button addTarget:self
                   action:@selector(chordPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[NSString stringWithFormat:@"%@", self.chords[k]]
                forState:UIControlStateNormal];
        [button setBackgroundColor:color];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"Quicksand-Bold" size:fontSize];
        [self.view addSubview:button];
        
        //change color brightness
        self.brightness *= 0.97;
        self.saturation *= 1.03;
    } /* for */
    
    //create randomize button
    CGFloat hue, saturation, brightness, alpha;
    [initialColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    for (k = 0; k < 8; k++){
        brightness *= 0.97;
        saturation *= 1.03;
    }
    UIColor *randomizeColor = [[UIColor alloc] initWithHue:hue saturation:saturation brightness:brightness alpha:1];
    UIButton *randomizeButton = [[UIButton alloc] initWithFrame:CGRectMake(width, height*3, width, height)];
    [randomizeButton addTarget:self
               action:@selector(randomizeProgression:)
     forControlEvents:UIControlEventTouchUpInside];
    [randomizeButton setBackgroundColor:randomizeColor];

    SVGKImage *random = [SVGKImage imageNamed:@"random.svg"];
    random.size = CGSizeMake(randomXSize, randomYSize);
    UIImage *icon = random.UIImage;
    [randomizeButton setImage:icon forState:UIControlStateNormal];
    [randomizeButton setImage:icon forState:UIControlStateHighlighted];
    
    [self.view addSubview:randomizeButton];
}

- (void)chordPressed:(UIButton *)sender
{
    ChartViewController *chartVC = [[ChartViewController alloc] initWithNibName:nil bundle:nil];
    chartVC.color = sender.backgroundColor;
    chartVC.chord = sender.titleLabel.text;
    [self.navigationController pushViewController:chartVC animated:YES];
}

- (void)randomizeProgression:(UIButton *)sender
{
    RandomizerViewController *randomizerVC = [[RandomizerViewController alloc] initWithNibName:nil bundle:nil];
    randomizerVC.color = sender.backgroundColor;
    randomizerVC.initialColor = [[UIColor alloc] initWithHue:self.hue saturation:self.saturation brightness:self.brightness alpha:1];
    randomizerVC.key = [self.chords objectAtIndex:0];
    randomizerVC.chords = self.chords;
    [self.navigationController pushViewController:randomizerVC animated:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end