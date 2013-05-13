//
//  DDNAddCharacterViewController.h
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/10/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionSheetPicker.h"

@interface DDNAddCharacterViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, assign) NSInteger selectedRace;
@property (nonatomic, assign) NSInteger selectedClass;
@property (nonatomic, strong) NSArray *races;
@property (nonatomic, strong) NSArray *classes;
@property (nonatomic, strong) NSString *name;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UIButton *raceButton;
@property (weak, nonatomic) IBOutlet UIButton *classButton;
@property (weak, nonatomic) IBOutlet UITextField *nameText;

- (IBAction)showRaces:(id)sender;
- (IBAction)showClasses:(id)sender;

@end
