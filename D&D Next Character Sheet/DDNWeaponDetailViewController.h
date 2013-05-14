//
//  DDNWeaponDetailViewController.h
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/12/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weapon.h"

@interface DDNWeaponDetailViewController : UITableViewController

@property (strong, nonatomic) Weapon *weapon;

@property (nonatomic, assign) NSInteger selectedRow;

@end
