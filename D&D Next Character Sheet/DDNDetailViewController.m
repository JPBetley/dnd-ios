//
//  DDNDetailViewController.m
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/10/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import "DDNDetailViewController.h"

@interface DDNDetailViewController ()
- (void)configureView;
@end

@implementation DDNDetailViewController

#pragma mark - Managing the detail item

- (void)setCharacter:(Character *)character {
    if (_character != character) {
        _character = character;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.

    for (UIViewController *v in self.viewControllers) {
        if ([v respondsToSelector:@selector(setCharacter:)]) {
            [v performSelector:@selector(setCharacter:) withObject:self.character];
        }
        if ([v respondsToSelector:@selector(setManagedObjectContext:)]) {
            [v performSelector:@selector(setManagedObjectContext:) withObject:self.managedObjectContext];
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [self saveCharacter:nil];
}

- (void)saveCharacter:(id)sender {
    //self.character.name = self.nameField.text;
    NSError *error;
    if(![self.managedObjectContext save:&error]){
        NSLog(@"[ERROR] COREDATA: Save raised an error - '%@'", [error description]);
		return;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
