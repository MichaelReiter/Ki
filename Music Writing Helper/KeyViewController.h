//
//  KeyViewController.h
//  Test ScrollView
//
//  Created by Michael Reiter on 2014-11-09.
//  Copyright (c) 2014 Michael Reiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChordsViewController.h"

@interface KeyViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *selectedKey;

- (NSArray *)generateKeysWithKey:(NSString *)key;

- (void)buttonPressed:(id)sender;

@end