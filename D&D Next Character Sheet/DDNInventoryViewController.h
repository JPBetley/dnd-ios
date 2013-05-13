//
//  DDNInventoryViewController.h
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/10/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"

@interface DDNInventoryViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) Character *character;
-(void)cancelNumberPad;
-(void)updateGp:(id)sender;
-(void)updateSp:(id)sender;
-(void)updateCp:(id)sender;
-(IBAction)done:(UIStoryboardSegue *)sender;
@end
