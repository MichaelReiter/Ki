//
//  KeyViewController.m
//  Test ScrollView
//
//  Created by Michael Reiter on 2014-11-09.
//  Copyright (c) 2014 Michael Reiter. All rights reserved.
//

#import "KeyViewController.h"
#import "ChordsViewController.h"
#import "InstructionsViewController.h"

@implementation KeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"tutorialShown"]){
        //show instructions only on first launch
        InstructionsViewController *instructionsVC = [[InstructionsViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:instructionsVC animated:NO];
        
        //prevent instructions from being shown again
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"tutorialShown"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    NSArray *keys = [[NSArray alloc] initWithObjects:@"A", @"Am", @"Bb", @"Bbm", @"B", @"Bm", @"C", @"Cm", @"C#", @"C#m", @"D", @"Dm", @"Eb", @"Ebm", @"E", @"Em", @"F", @"Fm", @"F#", @"F#m", @"G", @"Gm", @"G#", @"G#m", nil];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*3);
    scrollView.bounces = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    UIColor *color1 = [[UIColor alloc] initWithHue:0.464 saturation:0.5 brightness:0.85 alpha:1];
    UIColor *color2 = [[UIColor alloc] initWithHue:0.0806 saturation:0.6 brightness:0.95 alpha:1];
    UIColor *color3 = [[UIColor alloc] initWithHue:0.55 saturation:0.6 brightness:0.85 alpha:1];
    UIColor *color4 = [[UIColor alloc] initWithHue:0.0306 saturation:0.55 brightness:0.9 alpha:1];
    UIColor *color5 = [[UIColor alloc] initWithHue:0.122 saturation:0.55 brightness:1 alpha:1];
    UIColor *color6 = [[UIColor alloc] initWithHue:0.464 saturation:0.4 brightness:0.6 alpha:1];
    UIColor *color7 = [[UIColor alloc] initWithHue:0.522 saturation:0.38 brightness:0.50 alpha:1];
    UIColor *color8 = [[UIColor alloc] initWithHue:0.694 saturation:0.26 brightness:0.73 alpha:1];
    
    int k, x, fontSize;
    int y = 0;
    int width = self.view.frame.size.width/2;
    int height = self.view.frame.size.height/4 + 0.25;
    
    if (self.view.frame.size.width < 330){          //iPhone 4S, 5, 5S
        fontSize = 20;
    } else if (self.view.frame.size.width < 380){   //iPhone 6
        fontSize = 23;
        width += 1; //correct box sizing
    } else if (self.view.frame.size.width < 420){   //iPhone 6 Plus
        fontSize = 28;
    } else {                                        //iPad
        fontSize = 35;
    }
    
    for (k = 0; k < keys.count; k++){
        
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

        //create buttons
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [button addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[NSString stringWithFormat:@"%@", keys[k]]
                forState:UIControlStateNormal];
        switch ((k+1) % 8) {
            case 1:
                [button setBackgroundColor:color1];
                break;
            case 2:
                [button setBackgroundColor:color2];
                break;
            case 3:
                [button setBackgroundColor:color3];
                break;
            case 4:
                [button setBackgroundColor:color4];
                break;
            case 5:
                [button setBackgroundColor:color5];
                break;
            case 6:
                [button setBackgroundColor:color6];
                break;
            case 7:
                [button setBackgroundColor:color7];
                break;
            case 0:
                [button setBackgroundColor:color8];
                break;
        }
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"Quicksand-Bold" size:fontSize];
        [scrollView addSubview:button];
        [self.view addSubview:scrollView];
    } /* for */
}

- (NSArray *)generateKeysWithKey:(NSString *)key
{
    NSMutableArray *defaultMajorKey = [[NSMutableArray alloc] initWithObjects:@"A", @"Bb", @"B", @"C", @"C#", @"D", @"Eb", @"E", @"F", @"F#", @"G", @"G#", nil];
    
    NSMutableArray *defaultMinorKey = [[NSMutableArray alloc] initWithObjects:@"Am", @"Bbm", @"Bm", @"Cm", @"C#m", @"Dm", @"Ebm", @"Em", @"Fm", @"F#m", @"Gm", @"G#m", nil];
    
    
    int times;
    //take input for times from tapped cell so loop will repeat based on selected key
    if (![key hasSuffix:@"m"]){
        times = (unsigned int)[defaultMajorKey indexOfObject:key] + 1;
    } else {
        times = (unsigned int)[defaultMinorKey indexOfObject:key] + 1;
    }
    
    //shift default key to create selected key
    int k;
    for (k = 1; k < times; k++){
        [defaultMajorKey addObject:[defaultMajorKey objectAtIndex:0]];
        [defaultMajorKey removeObjectAtIndex:0];
        [defaultMinorKey addObject:[defaultMinorKey objectAtIndex:0]];
        [defaultMinorKey removeObjectAtIndex:0];
    }
    
    //apply key rules
    NSMutableArray *majorKey = [[NSMutableArray alloc] initWithObjects:[defaultMajorKey objectAtIndex:0],
                                [[defaultMajorKey objectAtIndex:2] stringByAppendingString:@"m"],
                                [[defaultMajorKey objectAtIndex:4] stringByAppendingString:@"m"],
                                [defaultMajorKey objectAtIndex:5],
                                [defaultMajorKey objectAtIndex:7],
                                [[defaultMajorKey objectAtIndex:9] stringByAppendingString:@"m"],
                                [[defaultMajorKey objectAtIndex:11] stringByAppendingString:@"dim"],
                                nil];
    
    NSMutableArray *minorKey = [[NSMutableArray alloc] initWithObjects:[defaultMinorKey objectAtIndex:0],
                                [[[defaultMinorKey objectAtIndex:2] substringToIndex:[[defaultMinorKey objectAtIndex:2] length] - 1]stringByAppendingString:@"dim"],
                                [[defaultMinorKey objectAtIndex:3] substringToIndex:[[defaultMinorKey objectAtIndex:3] length] - 1],
                                [defaultMinorKey objectAtIndex:5],
                                [defaultMinorKey objectAtIndex:7],
                                [[defaultMinorKey objectAtIndex:8] substringToIndex:[[defaultMinorKey objectAtIndex:8] length] - 1],
                                [[defaultMinorKey objectAtIndex:10] substringToIndex:[[defaultMinorKey objectAtIndex:10] length] - 1],
                                nil];
    
    self.selectedKey = [[NSMutableArray alloc] init];
    if (![key hasSuffix:@"m"]){
        [self.selectedKey addObjectsFromArray:majorKey];
    } else {
        [self.selectedKey addObjectsFromArray:minorKey];
    }
    
    return self.selectedKey;
}

- (void)buttonPressed:(UIButton *)sender
{
    [self generateKeysWithKey:sender.titleLabel.text];
    ChordsViewController *chordsVC = [[ChordsViewController alloc] initWithNibName:nil bundle:nil];
    chordsVC.chords = self.selectedKey;
    CGFloat hue, saturation, brightness, alpha;
    [sender.backgroundColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    chordsVC.hue = hue;
    chordsVC.saturation = saturation;
    chordsVC.brightness = brightness;
    [self.navigationController pushViewController:chordsVC animated:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
