//
//  Data.m
//  FlappyBlueprintTwo
//
//  Created by Nikki Durkin on 8/24/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Data.h"
#import "Defaults.h"

@implementation Data

+ (NSArray *)notesData {
    
    NSArray *messages = @[ @"I love you",
                           @"Blah Blah Blah",
                           @"Testing testing 1 2 3. This is a longer message that I'm testing",
                           @"Oh hello, cutie."
                           ];
    
    NSMutableArray *allData = [@[] mutableCopy];
    
    for (NSString *message in messages) {
        
        int lowerBound = 1;
        int upperBound = 100;
        NSInteger randomNumber = lowerBound + arc4random() % (upperBound - lowerBound);
        
        NSDictionary *dataset = @{ NOTE_MESSAGE_KEY : message,
                                   NOTE_NUMBER_KEY : [NSNumber numberWithInteger:randomNumber]
                                   };
        
        [allData addObject:dataset];
    }
    
    return allData;
}

@end
