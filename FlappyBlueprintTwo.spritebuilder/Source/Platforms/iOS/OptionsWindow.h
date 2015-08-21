//
//  OptionsWindow.h
//  FlappyBlueprintTwo
//
//  Created by Nikki Durkin on 8/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCSprite.h"

@protocol OptionsWindowDelegate <NSObject>

@required

- (void)okButtonTapped;

@end

@interface OptionsWindow : CCSprite

@property (weak, nonatomic) id <OptionsWindowDelegate> delegate;

@end
