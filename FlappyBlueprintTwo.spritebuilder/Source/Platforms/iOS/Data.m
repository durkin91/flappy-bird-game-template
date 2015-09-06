//
//  Data.m
//  FlappyBlueprintTwo
//
//  Created by Nikki Durkin on 8/24/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Data.h"
#import "Defaults.h"
#import "AdvancedSettings.h"

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

+ (CCColor *)startColorForGradientNode {
    
    CCColor *color;
    
    if (IS_RED_COLOR_SCHEME) {
        color = [CCColor colorWithRed:178 / 255.0 green:187 / 255.0 blue:200 / 255.0];
    }
    else {
        color = [CCColor colorWithRed:200 / 255.0 green:142 / 255.0 blue:198 / 255.0];
    }
    
    return color;
    
}

+ (CCColor *)endColorForGradientNode {
    
    CCColor *color;
    
    if (IS_RED_COLOR_SCHEME) {
        color = [CCColor colorWithRed:33 / 255.0 green:127 / 255.0 blue:204 / 255.0];
    }
    else {
        color = [CCColor colorWithRed:89 / 255.0 green:149 / 255.0 blue:204 / 255.0];
    }
    
    return color;
    
}

@end
