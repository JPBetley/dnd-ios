//
//  DDNWeaponViewController.h
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/12/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"
#import "Weapon.h"

@interface DDNWeaponViewController : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) Character *character;
@property (nonatomic, strong) NSMutableArray *weapons;
@property (nonatomic, strong) Weapon *selectedWeapon;

@end
