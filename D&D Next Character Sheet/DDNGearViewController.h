//
//  DDNGearViewController.h
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/13/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"

@interface DDNGearViewController : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) Character *character;
@property (nonatomic, strong) NSMutableArray *gear;
-(IBAction)selectGear:(UIStoryboardSegue *)segue;
-(IBAction)cancelGear:(UIStoryboardSegue *)segue;

@end
