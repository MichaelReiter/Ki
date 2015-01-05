//
//  ChordsViewController.h
//  Music Writing Helper
//
//  Created by Michael Reiter on 2014-11-10.
//  Copyright (c) 2014 Michael Reiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyViewController.h"

@interface ChordsViewController : UIViewController

@property (strong, nonatomic) NSArray *chords;
@property CGFloat hue;
@property CGFloat saturation;
@property CGFloat brightness;

- (void)chordPressed:(id)sender;

@end