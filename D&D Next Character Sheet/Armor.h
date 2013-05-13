//
//  Armor.h
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/10/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Character;

@interface Armor : NSManagedObject

@property (nonatomic, retain) NSNumber * ac;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * speed;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSSet *character;
@end

@interface Armor (CoreDataGeneratedAccessors)

- (void)addCharacterObject:(Character *)value;
- (void)removeCharacterObject:(Character *)value;
- (void)addCharacter:(NSSet *)values;
- (void)removeCharacter:(NSSet *)values;

@end
