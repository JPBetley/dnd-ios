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
    self.navigationItem.title = self.character.name;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self saveCharacter];
}

- (void)saveCharacter {
    //self.character.name = self.nameField.text;
    NSError *error;
    if(![self.managedObjectContext save:&error]){
        NSLog(@"[ERROR] COREDATA: Save raised an error - '%@'", [error description]);
		return;
    }
}

-(IBAction)itemSelected:(UIStoryboardSegue *)sender {
    self.tabBarController.selectedIndex = 1;
    [self saveCharacter];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
}

- (IBAction)tappedRightButton:(id)sender
{
    NSUInteger selectedIndex = [self selectedIndex];
    
    [self setSelectedIndex:selectedIndex + 1];
}

- (IBAction)tappedLeftButton:(id)sender
{
    NSUInteger selectedIndex = [self selectedIndex];
    
    [self setSelectedIndex:selectedIndex - 1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
