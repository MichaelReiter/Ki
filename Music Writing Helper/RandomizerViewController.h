//
//  RandomizerViewController.h
//  Music Writing Helper
//
//  Created by Michael Reiter on 2014-11-14.
//  Copyright (c) 2014 Michael Reiter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RandomizerViewController : UIViewController

@property UIColor *color;
@property UIColor *initialColor;
@property int numberOfChords;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) UILabel *numberLabel;
@property (strong, nonatomic) NSArray *chords;
@property (strong, nonatomic) UIButton *upButton;
@property (strong, nonatomic) UIButton *downButton;

- (void)upPressed;

- (void)downPressed;

- (void)goPressed;

@end
