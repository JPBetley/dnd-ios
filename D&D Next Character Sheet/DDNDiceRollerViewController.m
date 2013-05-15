//
//  DDNDiceRollerViewController.m
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/10/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import "DDNDiceRollerViewController.h"

@interface DDNDiceRollerViewController ()
@property UITextField *dieText;
@property UIBarButtonItem *barButtonItem;
enum {
    d4_TAG = 0,
    d6_TAG,
    d8_TAG,
    d10_TAG,
    d12_TAG,
    d20_TAG
};
@end

@implementation DDNDiceRollerViewController

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
    self.barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Roll" style:UIBarButtonItemStyleBordered target:self action:@selector(rollDice:)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)canBecomeFirstResponder {
    return YES;
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
    self.tabBarController.navigationItem.rightBarButtonItem = self.barButtonItem;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
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
    [self resignFirstResponder];
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    [super viewWillDisappear:animated];
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake)
    {
        [self rollDice:self];
    }
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
    CGRect statFrame = self.dieText.frame;
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
    self.dieText = textField;
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlack;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelDice)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(editDice)],
                           nil];
    [numberToolbar sizeToFit];
    self.dieText.inputAccessoryView = numberToolbar;
}

-(void)cancelDice {
    [self.dieText resignFirstResponder];
}

-(void)editDice {
    switch ([self.dieText tag]) {
            
        case d4_TAG:
            self.d4Stepper.value = self.dieText.text.doubleValue;
            break;
        case d6_TAG:
            self.d6Stepper.value = self.dieText.text.doubleValue;
            break;
        case d8_TAG:
            self.d8Stepper.value = self.dieText.text.doubleValue;
            break;
        case d10_TAG:
            self.d10Stepper.value = self.dieText.text.doubleValue;
            break;
        case d12_TAG:
            self.d12Stepper.value = self.dieText.text.doubleValue;
            break;
        case d20_TAG:
            self.d20Stepper.value = self.dieText.text.doubleValue;
            break;
        default:
            break;
    }
    [self.dieText resignFirstResponder];
}

- (IBAction)rollDice:(id)sender {
    int totalRoll = 0;
    
    totalRoll += [self rollDie:4 times:self.d4.text.intValue];
    totalRoll += [self rollDie:6 times:self.d6.text.intValue];
    totalRoll += [self rollDie:8 times:self.d8.text.intValue];
    totalRoll += [self rollDie:10 times:self.d10.text.intValue];
    totalRoll += [self rollDie:12 times:self.d12.text.intValue];
    totalRoll += [self rollDie:20 times:self.d20.text.intValue];
    
    NSString *message = [NSString stringWithFormat:@"You rolled a total of %d", totalRoll];
    
    [[[UIAlertView alloc] initWithTitle:@"Dice Roll!" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}

-(int)rollDie:(int)die times:(int)number {
    int val = 0;
    for (int i = 0; i < number; i++) {
        val += [self getRandomNumberBetween:1 to:die];
    }
    return val;
}

-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}

- (IBAction)changeStepperValue:(UIStepper *)sender {
    switch ([sender tag]) {
            
        case d4_TAG:
            self.d4.text = [NSString stringWithFormat:@"%d", (int)self.d4Stepper.value];
            break;
        case d6_TAG:
            self.d6.text = [NSString stringWithFormat:@"%d", (int)self.d6Stepper.value];
            break;
        case d8_TAG:
            self.d8.text = [NSString stringWithFormat:@"%d", (int)self.d8Stepper.value];
            break;
        case d10_TAG:
            self.d10.text = [NSString stringWithFormat:@"%d", (int)self.d10Stepper.value];
            break;
        case d12_TAG:
            self.d12.text = [NSString stringWithFormat:@"%d", (int)self.d12Stepper.value];
            break;
        case d20_TAG:
            self.d20.text = [NSString stringWithFormat:@"%d", (int)self.d20Stepper.value];
            break;
        default:
            break;
    }
}
@end
