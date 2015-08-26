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
    
    
    NSMutableArray *allData = [NSMutableArray array];
    
    for (NSString *message in messages) {
        
        NSNumber *noteNumber = [NSNumber numberWithInteger:[messages indexOfObject:message] + 1];
        
        NSDictionary *dataset = @{ NOTE_MESSAGE_KEY : message,
                                   NOTE_NUMBER_KEY : noteNumber
                                   };
        
        [allData addObject:dataset];
    }
    
    return allData;
}


@end
