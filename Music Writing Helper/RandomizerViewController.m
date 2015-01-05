//
//  RandomizerViewController.m
//  Music Writing Helper
//
//  Created by Michael Reiter on 2014-11-14.
//  Copyright (c) 2014 Michael Reiter. All rights reserved.
//

#import "RandomizerViewController.h"
#import "ProgressionViewController.h"
#import "SVGKImage.h"

@implementation RandomizerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:self.color];
    
    //set the default number of chords to 4
    self.numberOfChords = 4;
    
    int fontSize, upPositionModifier, downPositionModifier, arrowIconSize, numberLabelFontSize;
    
    if (self.view.frame.size.width < 330){          //iPhone 4S, 5, 5S
        fontSize = 20;
        upPositionModifier = 50;
        downPositionModifier = 57;
        if (self.view.frame.size.height < 500){
            downPositionModifier -= 4;  //correct down arrow position for iPhone 4S
        }
        arrowIconSize = 25;
        numberLabelFontSize = 50;
    } else if (self.view.frame.size.width < 380){   //iPhone 6
        fontSize = 23;
        upPositionModifier = 52;
        downPositionModifier = 70;
        arrowIconSize = 30;
        numberLabelFontSize = 55;
    } else if (self.view.frame.size.width < 420){   //iPhone 6 Plus
        fontSize = 28;
        upPositionModifier = 60;
        downPositionModifier = 80;
        arrowIconSize = 35;
        numberLabelFontSize = 65;
    } else {                                        //iPad
        fontSize = 35;
        upPositionModifier = 50;
        downPositionModifier = 100;
        arrowIconSize = 50;
        numberLabelFontSize = 75;
    }

    //create instructions label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/8, self.view.frame.size.width, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"Select number of chords";
    titleLabel.font = [UIFont fontWithName:@"Quicksand-Bold" size:fontSize];
    [titleLabel setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/9)];
    [self.view addSubview:titleLabel];
    
    //create up button
    self.upButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2.2 - upPositionModifier, 100, 50)];
    [self.upButton addTarget:self
               action:@selector(upPressed)
     forControlEvents:UIControlEventTouchUpInside];
    SVGKImage *upArrow = [SVGKImage imageNamed:@"upArrow.svg"];
    upArrow.size = CGSizeMake(arrowIconSize, arrowIconSize);
    UIImage *upIcon = upArrow.UIImage;
    [self.upButton setImage:upIcon forState:UIControlStateNormal];
    [self.upButton setImage:upIcon forState:UIControlStateHighlighted];
    [self.view addSubview:self.upButton];
    
    //create number label
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2 - 50, self.view.frame.size.width/2, 100)];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    [self.numberLabel setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    self.numberLabel.textColor = [UIColor whiteColor];
    self.numberLabel.backgroundColor = [UIColor clearColor];
    self.numberLabel.text = [NSString stringWithFormat:@"%d", self.numberOfChords];
    self.numberLabel.font = [UIFont fontWithName:@"Quicksand-Bold" size:numberLabelFontSize];
    [self.view addSubview:self.numberLabel];
    
    //create down button
    self.downButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2.2 + downPositionModifier, 100, 50)];
    [self.downButton addTarget:self
               action:@selector(downPressed)
     forControlEvents:UIControlEventTouchUpInside];
    SVGKImage *downArrow = [SVGKImage imageNamed:@"downArrow.svg"];
    downArrow.size = CGSizeMake(arrowIconSize, arrowIconSize);
    UIImage *downIcon = downArrow.UIImage;
    [self.downButton setImage:downIcon forState:UIControlStateNormal];
    [self.downButton setImage:downIcon forState:UIControlStateHighlighted];
    [self.view addSubview:self.downButton];
    
    //create go button
    UIButton *goButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/1.3, 100, 50)];
    [goButton addTarget:self
                   action:@selector(goPressed)
         forControlEvents:UIControlEventTouchUpInside];
    [goButton setTitle:@"Go"
                forState:UIControlStateNormal];
    [goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    goButton.titleLabel.font = [UIFont fontWithName:@"Quicksand-Bold" size:fontSize];
    [self.view addSubview:goButton];
}

- (void)upPressed
{
    self.numberOfChords += 1;
    self.numberLabel.text = [NSString stringWithFormat:@"%d", self.numberOfChords];
    if (self.numberOfChords == 8){
        self.upButton.enabled = NO;
        self.upButton.alpha = 0.5;
    }
    if (self.numberOfChords == 3){
        self.downButton.enabled = YES;
        self.downButton.alpha = 1;
    }
}

- (void)downPressed
{
    self.numberOfChords -= 1;
    self.numberLabel.text = [NSString stringWithFormat:@"%d", self.numberOfChords];
    if (self.numberOfChords == 2){
        self.downButton.enabled = NO;
        self.downButton.alpha = 0.5;
    }
    if (self.numberOfChords == 7){
        self.upButton.enabled = YES;
        self.upButton.alpha = 1;
    }
}

- (void)goPressed
{
    ProgressionViewController *progressionVC = [[ProgressionViewController alloc] initWithNibName:nil bundle:nil];
    progressionVC.key = self.key;
    progressionVC.numberOfChords = self.numberOfChords;
    progressionVC.chords = self.chords;
    progressionVC.initialColor = self.initialColor;
    [self.navigationController pushViewController:progressionVC animated:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
