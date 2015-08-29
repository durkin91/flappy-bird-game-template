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
    
    NSArray *messages = @[ @"You never forget to buy toilet paper.",
                           @"You always remember to buy me that thick strawberry yoghurt that I love.",
                           @"You buy cat food for Calico, even though you really don't like cats.",
                           @"You always make me laugh."
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
