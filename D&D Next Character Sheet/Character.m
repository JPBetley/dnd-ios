//
//  Character.m
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/10/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import "Character.h"
#import "Armor.h"
#import "Gear.h"
#import "Race.h"
#import "Weapon.h"


@implementation Character

@dynamic charisma;
@dynamic constitution;
@dynamic dexterity;
@dynamic experience;
@dynamic health;
@dynamic intelligence;
@dynamic max_health;
@dynamic name;
@dynamic strength;
@dynamic wisdom;
@dynamic armor;
@dynamic gear;
@dynamic profession;
@dynamic race;
@dynamic weapons;
@dynamic sp;
@dynamic gp;
@dynamic cp;
@dynamic ac;

- (NSNumber *)level {
    if (self.experience.intValue > 460000) {
        return [NSNumber numberWithInt:20];
    } else if (self.experience.intValue > 390000) {
        return [NSNumber numberWithInt:19];
    } else if (self.experience.intValue > 330000) {
        return [NSNumber numberWithInt:18];
    } else if (self.experience.intValue > 280000) {
        return [NSNumber numberWithInt:17];
    } else if (self.experience.intValue > 230000) {
        return [NSNumber numberWithInt:16];
    } else if (self.experience.intValue > 190000) {
        return [NSNumber numberWithInt:15];
    } else if (self.experience.intValue > 150000) {
        return [NSNumber numberWithInt:14];
    } else if (self.experience.intValue > 120000) {
        return [NSNumber numberWithInt:13];
    } else if (self.experience.intValue > 96000) {
        return [NSNumber numberWithInt:12];
    } else if (self.experience.intValue > 77000) {
        return [NSNumber numberWithInt:11];
    } else if (self.experience.intValue > 56000) {
        return [NSNumber numberWithInt:10];
    } else if (self.experience.intValue > 38000) {
        return [NSNumber numberWithInt:9];
    } else if (self.experience.intValue > 25000) {
        return [NSNumber numberWithInt:8];
    } else if (self.experience.intValue > 16000) {
        return [NSNumber numberWithInt:7];
    } else if (self.experience.intValue > 9500) {
        return [NSNumber numberWithInt:6];
    } else if (self.experience.intValue > 4750) {
        return [NSNumber numberWithInt:5];
    } else if (self.experience.intValue > 2250) {
        return [NSNumber numberWithInt:4];
    } else if (self.experience.intValue > 950) {
        return [NSNumber numberWithInt:3];
    } else if (self.experience.intValue > 250) {
        return [NSNumber numberWithInt:2];
    } else {
        return [NSNumber numberWithInt:1];
    }
}

- (NSString *)getModifierFrom:(NSNumber *)value {
    int val = ([value intValue] - 10) / 2;
    NSString * string;
    if (val > 0) {
        string = [NSString stringWithFormat:@"+%d", val];
    } else {
        string = [NSString stringWithFormat:@"%d", val];
    }
    return string;
}

@end
