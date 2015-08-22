//
//  GiftInfo.m
//  FlappyBlueprintTwo
//
//  Created by Nikki Durkin on 8/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GiftInfo.h"
#import "Options.h"

@implementation GiftInfo

- (void) homeButtonTapped {
    
    [Options playTapSound];
    
    CCScene *homeScene = [CCBReader loadAsScene:@"MainMenu"];
    [[CCDirector sharedDirector] replaceScene:homeScene];

}

@end
