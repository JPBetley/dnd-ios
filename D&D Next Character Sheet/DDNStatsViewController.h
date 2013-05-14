//
//  DDNStatsViewController.h
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/10/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"

@interface DDNStatsViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) Character *character;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UITextField *healthText;
@property (weak, nonatomic) IBOutlet UITextField *maxHealthText;
@property (weak, nonatomic) IBOutlet UITextField *armorClassText;
@property (weak, nonatomic) IBOutlet UITextField *strengthText;
@property (weak, nonatomic) IBOutlet UITextField *dexterityText;
@property (weak, nonatomic) IBOutlet UITextField *constitutionText;
@property (weak, nonatomic) IBOutlet UITextField *intelligenceText;
@property (weak, nonatomic) IBOutlet UITextField *wisdomText;
@property (weak, nonatomic) IBOutlet UITextField *charismaText;
@property (weak, nonatomic) IBOutlet UIStepper *healthStepper;
@property (weak, nonatomic) IBOutlet UIStepper *maxHealthStepper;
@property (weak, nonatomic) IBOutlet UIStepper *armorClassStepper;
@property (weak, nonatomic) IBOutlet UIStepper *strengthStepper;
@property (weak, nonatomic) IBOutlet UIStepper *dexterityStepper;
@property (weak, nonatomic) IBOutlet UIStepper *constitutionStepper;
@property (weak, nonatomic) IBOutlet UIStepper *intelligenceStepper;
@property (weak, nonatomic) IBOutlet UIStepper *wisdomStepper;
@property (weak, nonatomic) IBOutlet UIStepper *charismaStepper;
@property (weak, nonatomic) IBOutlet UILabel *strMod;
@property (weak, nonatomic) IBOutlet UILabel *dexMod;
@property (weak, nonatomic) IBOutlet UILabel *conMod;
@property (weak, nonatomic) IBOutlet UILabel *intMod;
@property (weak, nonatomic) IBOutlet UILabel *wisMod;
@property (weak, nonatomic) IBOutlet UILabel *chaMod;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)incrementStat:(UIStepper *)sender;
-(void)editStat;
-(void)cancelStat;


@end
