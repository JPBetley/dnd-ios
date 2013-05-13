//
//  Profession.m
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/10/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import "Profession.h"
#import "Character.h"


@implementation Profession

@dynamic name;
@dynamic character;

- (NSString *)description {
    return self.name;
}

@end
