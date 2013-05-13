//
//  Character.h
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/10/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Armor, Gear, Race, Weapon;

@interface Character : NSManagedObject

@property (nonatomic, retain) NSNumber * charisma;
@property (nonatomic, retain) NSNumber * constitution;
@property (nonatomic, retain) NSNumber * dexterity;
@property (nonatomic, retain) NSNumber * experience;
@property (nonatomic, retain) NSNumber * health;
@property (nonatomic, retain) NSNumber * intelligence;
@property (nonatomic, retain) NSNumber * max_health;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * strength;
@property (nonatomic, retain) NSNumber * wisdom;
@property (nonatomic, retain) Armor *armor;
@property (nonatomic, retain) NSSet *gear;
@property (nonatomic, retain) NSManagedObject *profession;
@property (nonatomic, retain) Race *race;
@property (nonatomic, retain) NSSet *weapons;
@property (nonatomic, retain) NSNumber * ac;
@property (nonatomic, retain) NSNumber * sp;
@property (nonatomic, retain) NSNumber * gp;
@property (nonatomic, retain) NSNumber * cp;
@property (nonatomic, readonly) NSNumber *level;
@end

@interface Character (CoreDataGeneratedAccessors)

- (void)addGearObject:(Gear *)value;
- (void)removeGearObject:(Gear *)value;
- (void)addGear:(NSSet *)values;
- (void)removeGear:(NSSet *)values;

- (void)addWeaponsObject:(Weapon *)value;
- (void)removeWeaponsObject:(Weapon *)value;
- (void)addWeapons:(NSSet *)values;
- (void)removeWeapons:(NSSet *)values;
- (NSString *)getModifierFrom:(NSNumber *)value;

@end
