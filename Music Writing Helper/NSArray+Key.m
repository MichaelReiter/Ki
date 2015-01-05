//
//  NSArray+Key.m
//  Music Writing Helper
//
//  Created by Michael Reiter on 2014-10-17.
//  Copyright (c) 2014 Michael Reiter. All rights reserved.
//

#import "NSArray+Key.h"

@implementation NSArray (Key)

- (NSMutableArray *)randomProgression:(NSArray *)key Chords:(NSNumber *)chords
{
    int k, randomIndex;
    int chordsInt = [chords unsignedIntValue];
    NSMutableArray *progressionArray = [[NSMutableArray alloc] init];
    NSMutableArray *finalProgression = [[NSMutableArray alloc] init];
    
    //initialize array so the following loops' actions are in bounds
    for (k=0; k < chordsInt; k++){
        [progressionArray addObject:@0];
    }

    //loop to create array of random nonconsecutive numbers
    k = 0;
    while (k < chordsInt){
        randomIndex = arc4random_uniform(7);
        if (k == 0 || randomIndex != [[progressionArray objectAtIndex: k-1] intValue]){
            [progressionArray replaceObjectAtIndex:k withObject:[NSNumber numberWithInt:randomIndex]];
            k += 1;
        }
    }
    
    //loop to convert numbers to chords
    for (k=0; k < chordsInt; k++){
        randomIndex = arc4random_uniform(chordsInt);
        
        [finalProgression addObject:[NSString stringWithFormat:@"%@", [key objectAtIndex:[[progressionArray objectAtIndex:k] unsignedIntValue]]]];
    }
    return finalProgression;
}

@end