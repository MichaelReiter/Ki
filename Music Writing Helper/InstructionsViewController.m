//
//  InstructionsViewController.m
//  Music Writing Helper
//
//  Created by Michael Reiter on 2014-12-16.
//  Copyright (c) 2014 Michael Reiter. All rights reserved.
//

#import "InstructionsViewController.h"

@implementation InstructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor alloc] initWithHue:0.464 saturation:0.5 brightness:0.85 alpha:1];
    
    int fontSize;
    
    if (self.view.frame.size.width < 330){          //iPhone 4S, 5, 5S
        fontSize = 18;
    } else if (self.view.frame.size.width < 380){   //iPhone 6
        fontSize = 20;
    } else if (self.view.frame.size.width < 420){   //iPhone 6 Plus
        fontSize = 25;
    } else {                                        //iPad
        fontSize = 33;
    }
    
    //create title label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/8, self.view.frame.size.width, 50)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"Welcome to Ki";
    titleLabel.font = [UIFont fontWithName:@"Quicksand-Bold" size:fontSize*1.25];
    [titleLabel setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/11)];
    [self.view addSubview:titleLabel];
    
    //create instructions label
    UILabel *instructionsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/7, self.view.frame.size.width*0.8, 800)];
    instructionsLabel.textAlignment = NSTextAlignmentCenter;
    instructionsLabel.textColor = [UIColor whiteColor];
    instructionsLabel.backgroundColor = [UIColor clearColor];
    instructionsLabel.text = @"Swipe right to go back.";
    instructionsLabel.font = [UIFont fontWithName:@"Quicksand-Bold" size:fontSize];
    [instructionsLabel setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    instructionsLabel.numberOfLines = 0;
    [self.view addSubview:instructionsLabel];
    
    //create continue button
    UIButton *continueButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 100, self.view.frame.size.height/1.3, 200, 50)];
    [continueButton addTarget:self
                 action:@selector(continuePressed)
       forControlEvents:UIControlEventTouchUpInside];
    [continueButton setTitle:@"Continue"
              forState:UIControlStateNormal];
    [continueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    continueButton.titleLabel.font = [UIFont fontWithName:@"Quicksand-Bold" size:fontSize];
    [self.view addSubview:continueButton];
}

- (void)continuePressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
