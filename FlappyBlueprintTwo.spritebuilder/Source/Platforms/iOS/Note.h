//
//  Note.h
//  FlappyBlueprintTwo
//
//  Created by Nikki Durkin on 8/24/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Note : CCSprite

@property (nonatomic) BOOL isActive;
@property (strong, nonatomic) NSString *currentNoteMessage;
@property (nonatomic) NSInteger currentNoteNumber;


@end
