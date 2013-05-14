//
//  DDNDetailViewController.h
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/10/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"

@interface DDNDetailViewController : UITabBarController <UITabBarDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) Character *character;

- (void)saveCharacter;
-(IBAction)itemSelected:(UIStoryboardSegue *)sender;

@end
