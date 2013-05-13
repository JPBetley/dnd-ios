//
//  DDNStatsViewController.m
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/10/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import "DDNStatsViewController.h"
#import "Profession.h"
#import "Race.h"

enum {
    HEALTH_TAG = 0,
    MAX_HEALTH_TAG,
    ARMOR_CLASS_TAG,
    STRENGTH_TAG,
    DEXTERITY_TAG,
    CONSTITUTION_TAG,
    INTELLIGENCE_TAG,
    WISDOM_TAG,
    CHARISMA_TAG
};

@interface DDNStatsViewController ()
@property UITextField *statText;
@end

@implementation DDNStatsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.classLabel.text = ((Profession *)self.character.profession).name;
    self.raceLabel.text = ((Race *)self.character.race).name;

    [self refreshStats];
}

- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect statFrame = self.statText.frame;
    CGRect aRect = self.view.frame;
    aRect.size.height -= (kbSize.height);
    if (!CGRectContainsPoint(aRect, statFrame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, (statFrame.origin.y - aRect.size.height - statFrame.size.height + 20));
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self.scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    self.statText = textField;
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelStat)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(editStat)],
                           nil];
    [numberToolbar sizeToFit];
    self.statText.inputAccessoryView = numberToolbar;
}

-(void)cancelStat {
    [self.statText resignFirstResponder];
}

-(void)editStat {
    switch ([self.statText tag]) {
        
        case HEALTH_TAG:
            self.character.health = [NSNumber numberWithInt:self.statText.text.intValue];
            if (self.character.health.intValue < -50) {
                self.character.health = [NSNumber numberWithInt:-50];
            } else if (self.character.health.intValue > 99) {
                self.character.health = [NSNumber numberWithInt:99];
            }
            self.statText.text = self.character.health.description;
            break;
        case MAX_HEALTH_TAG:
            self.character.max_health = [NSNumber numberWithInt:self.statText.text.intValue];
            if (self.character.max_health.intValue > 99) {
                self.character.max_health = [NSNumber numberWithInt:99];
            }
            self.statText.text = self.character.max_health.description;
            break;
        case ARMOR_CLASS_TAG:
            if (self.statText.text.intValue < 0) {
                self.statText.text = @"0";
            } else if (self.statText.text.intValue > 20) {
                self.statText.text = @"20";
            }
            self.character.ac = [NSNumber numberWithInt:self.statText.text.intValue];
            break;
        case STRENGTH_TAG:
            if (self.statText.text.intValue < 0) {
                self.statText.text = @"0";
            } else if (self.statText.text.intValue > 20) {
                self.statText.text = @"20";
            }
            self.character.strength = [NSNumber numberWithInt:self.statText.text.intValue];
            break;
        case DEXTERITY_TAG:
            if (self.statText.text.intValue < 0) {
                self.statText.text = @"0";
            } else if (self.statText.text.intValue > 20) {
                self.statText.text = @"20";
            }
            self.character.dexterity = [NSNumber numberWithInt:self.statText.text.intValue];
            break;
        case CONSTITUTION_TAG:
            if (self.statText.text.intValue < 0) {
                self.statText.text = @"0";
            } else if (self.statText.text.intValue > 20) {
                self.statText.text = @"20";
            }
            self.character.constitution = [NSNumber numberWithInt:self.statText.text.intValue];
            break;
        case INTELLIGENCE_TAG:
            if (self.statText.text.intValue < 0) {
                self.statText.text = @"0";
            } else if (self.statText.text.intValue > 20) {
                self.statText.text = @"20";
            }
            self.character.intelligence = [NSNumber numberWithInt:self.statText.text.intValue];
            break;
        case WISDOM_TAG:
            if (self.statText.text.intValue < 0) {
                self.statText.text = @"0";
            } else if (self.statText.text.intValue > 20) {
                self.statText.text = @"20";
            }
            self.character.wisdom = [NSNumber numberWithInt:self.statText.text.intValue];
            break;
        case CHARISMA_TAG:
            if (self.statText.text.intValue < 0) {
                self.statText.text = @"0";
            } else if (self.statText.text.intValue > 20) {
                self.statText.text = @"20";
            }
            self.character.charisma = [NSNumber numberWithInt:self.statText.text.intValue];
            break;
            
        default:
            break;
    }
    [self refreshStats];
    [self.statText resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)incrementStat:(UIStepper *)sender {
    switch ([sender tag]) {
        case HEALTH_TAG:
            self.character.health = [NSNumber numberWithDouble:sender.value];
            break;
        case MAX_HEALTH_TAG:
            self.character.max_health = [NSNumber numberWithDouble:sender.value];
            break;
        case ARMOR_CLASS_TAG:
            self.character.ac = [NSNumber numberWithDouble:sender.value];
            break;
        case STRENGTH_TAG:
            self.character.strength = [NSNumber numberWithDouble:sender.value];
            break;
        case DEXTERITY_TAG:
            self.character.dexterity = [NSNumber numberWithDouble:sender.value];
            break;
        case CONSTITUTION_TAG:
            self.character.constitution = [NSNumber numberWithDouble:sender.value];
            break;
        case INTELLIGENCE_TAG:
            self.character.intelligence = [NSNumber numberWithDouble:sender.value];
            break;
        case WISDOM_TAG:
            self.character.wisdom = [NSNumber numberWithDouble:sender.value];
            break;
        case CHARISMA_TAG:
            self.character.charisma = [NSNumber numberWithDouble:sender.value];
            break;
            
        default:
            break;
    }
    [self refreshStats];
}

-(void)refreshStats {
    if (self.character.health.doubleValue < 0) {
        if (self.character.health.doubleValue < -9) {
            self.healthText.font = [UIFont systemFontOfSize:12.0f];
        } else {
            self.healthText.font = [UIFont systemFontOfSize:14.0f];
        }
        self.healthText.textColor = [UIColor redColor];
    } else {
        self.healthText.textColor = [UIColor blackColor];
    }
    self.healthText.text = self.character.health.description;
    self.maxHealthText.text = self.character.max_health.description;
    self.armorClassText.text = self.character.ac.description;
    self.strengthText.text = self.character.strength.description;
    self.dexterityText.text = self.character.dexterity.description;
    self.constitutionText.text = self.character.constitution.description;
    self.intelligenceText.text = self.character.intelligence.description;
    self.wisdomText.text = self.character.wisdom.description;
    self.charismaText.text = self.character.charisma.description;
    
    self.strMod.text = [self.character getModifierFrom:self.character.strength];
    self.dexMod.text = [self.character getModifierFrom:self.character.dexterity];
    self.conMod.text = [self.character getModifierFrom:self.character.constitution];
    self.intMod.text = [self.character getModifierFrom:self.character.intelligence];
    self.wisMod.text = [self.character getModifierFrom:self.character.wisdom];
    self.chaMod.text = [self.character getModifierFrom:self.character.charisma];
    
    self.healthStepper.value = self.character.health.doubleValue;
    self.maxHealthStepper.value = self.character.max_health.doubleValue;
    self.armorClassStepper.value = self.character.ac.doubleValue;
    self.strengthStepper.value = self.character.strength.doubleValue;
    self.dexterityStepper.value = self.character.dexterity.doubleValue;
    self.constitutionStepper.value = self.character.constitution.doubleValue;
    self.intelligenceStepper.value = self.character.intelligence.doubleValue;
    self.wisdomStepper.value = self.character.wisdom.doubleValue;
    self.charismaStepper.value = self.character.charisma.doubleValue;
}
@end
