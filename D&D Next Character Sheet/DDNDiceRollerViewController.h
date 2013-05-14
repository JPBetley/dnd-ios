//
//  DDNDiceRollerViewController.h
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/10/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDNDiceRollerViewController : UIViewController
- (IBAction)rollDice:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *d4;
@property (weak, nonatomic) IBOutlet UITextField *d6;
@property (weak, nonatomic) IBOutlet UITextField *d8;
@property (weak, nonatomic) IBOutlet UITextField *d10;
@property (weak, nonatomic) IBOutlet UITextField *d12;
@property (weak, nonatomic) IBOutlet UITextField *d20;
@property (weak, nonatomic) IBOutlet UIStepper *d4Stepper;
@property (weak, nonatomic) IBOutlet UIStepper *d6Stepper;
@property (weak, nonatomic) IBOutlet UIStepper *d8Stepper;
@property (weak, nonatomic) IBOutlet UIStepper *d10Stepper;
@property (weak, nonatomic) IBOutlet UIStepper *d12Stepper;
@property (weak, nonatomic) IBOutlet UIStepper *d20Stepper;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)changeStepperValue:(UIStepper *)sender;


@end
