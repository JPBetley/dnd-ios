//
//  DDNGearListViewController.h
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/13/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gear.h"

@interface DDNGearListViewController : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) Character *character;
@property (strong, nonatomic) NSMutableArray *gear;

@end
