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

//---------------------------------------------------------------------------
/*
 * Input the notes messages here
 */


+ (NSArray *)notesMessages {
    
    NSArray *messages = @[ @"This is a long message with weird wrapping",
                           @"Testing this message. Testing this message.",
                           @"Testing testing 1 2 3. This is a longer message that I'm testing",
                           @"Oh hello, cutie."
                           ];

    return messages;
}

//---------------------------------------------------------------------------









+ (NSArray *)notesData {
    
    NSArray *messages = [Data notesMessages];
    
    NSInteger maxNoteNumber = 0;
    
    if ([messages count] > MAXIMUM_NOTE_NUMBER) {
        
        maxNoteNumber = [messages count];
    }
    
    else {
        
        maxNoteNumber = MAXIMUM_NOTE_NUMBER;
    }
    
    
    NSMutableArray *allData = [NSMutableArray array];
    
    for (NSString *message in messages) {
        
        int lowerBound = 1;
        int upperBound = MAXIMUM_NOTE_NUMBER;
        
        NSInteger randomNumber = lowerBound + arc4random() % (upperBound - lowerBound);
        
        while ([Data number:randomNumber hasAlreadyBeenUsedInData:allData]) {
            
            randomNumber = lowerBound + arc4random() % (upperBound - lowerBound);
        }
        
        NSDictionary *dataset = @{ NOTE_MESSAGE_KEY : message,
                                   NOTE_NUMBER_KEY : [NSNumber numberWithInteger:randomNumber]
                                   };
        
        [allData addObject:dataset];
    }
    
    return allData;
}

+ (BOOL)number:(NSInteger)number hasAlreadyBeenUsedInData:(NSMutableArray *)allData {
    
    for (NSDictionary *dictionary in allData) {
        
        NSNumber *noteNumber = dictionary[NOTE_NUMBER_KEY];
        
        if (number == [noteNumber integerValue]) {
            return YES;
        }
    }
    
    return NO;
}

@end
