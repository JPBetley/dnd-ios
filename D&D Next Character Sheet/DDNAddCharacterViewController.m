//
//  DDNAddCharacterViewController.m
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/10/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import "DDNAddCharacterViewController.h"

@interface DDNAddCharacterViewController ()

@end

@implementation DDNAddCharacterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self fetchClasses];
    [self fetchRaces];
    self.selectedClass = -1;
    self.selectedRace = -1;
    //self.raceButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    //self.classButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length > 0) {
        [textField resignFirstResponder];
        return YES;
    } else {
        return NO;
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"done"]) {
        if (self.nameText.text.length == 0 || self.selectedClass == -1 || self.selectedRace == -1) {
            NSString *message = [NSString stringWithFormat:@"Please fill all fields"];
            [[[UIAlertView alloc] initWithTitle:@"Woops!" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            return NO;
        }
    }
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.name = self.nameText.text;
}

- (IBAction)showRaces:(id)sender {
    //[ActionSheetCustomPicker showPickerWithTitle:@"Select Race" delegate:self.professionDelegate showCancelButton:YES origin:self];
    NSInteger val = self.selectedRace == -1 ? 0 : self.selectedRace;
    [DDNPicker showPickerWithTitle:@"Select Race" rows:self.races initialSelection:val target:self successAction:@selector(raceWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}

- (IBAction)showClasses:(id)sender {
    NSInteger val = self.selectedClass == -1 ? 0 : self.selectedClass;
    [DDNPicker showPickerWithTitle:@"Select Class" rows:self.classes initialSelection:val target:self successAction:@selector(classWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}

- (void)raceWasSelected:(NSNumber *)selectedIndex element:(id)element {
    self.selectedRace = [selectedIndex intValue];
    
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    [self.raceButton setTitle:[[self.races objectAtIndex:self.selectedRace] name] forState:UIControlStateNormal];
}

- (void)classWasSelected:(NSNumber *)selectedIndex element:(id)element {
    self.selectedClass = [selectedIndex intValue];
    
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    [self.classButton setTitle:[[self.classes objectAtIndex:self.selectedClass] name] forState:UIControlStateNormal];
}

- (void)actionPickerCancelled:(id)sender {
    NSLog(@"Delegate has been informed that ActionSheetPicker was cancelled");
}

- (void)fetchClasses {
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Profession" inManagedObjectContext:_managedObjectContext];
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSError *error;
    NSMutableArray *mutableFetchResults = [[_managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (!mutableFetchResults) {
        // Handle the error.
        // This is a serious error and should advise the user to restart the application
    }
    // Save our fetched data to an array
    self.classes = mutableFetchResults;
}

- (void)fetchRaces {
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Race" inManagedObjectContext:_managedObjectContext];
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSError *error;
    NSMutableArray *mutableFetchResults = [[_managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (!mutableFetchResults) {
        // Handle the error.
        // This is a serious error and should advise the user to restart the application
    }
    // Save our fetched data to an array
    self.races = mutableFetchResults;
}


@end
