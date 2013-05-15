//
//  DDNArmorViewController.m
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/13/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import "DDNArmorViewController.h"
#import "DDNArmorDetailViewController.h"

@interface DDNArmorViewController ()

@end

@implementation DDNArmorViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchArmor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.selectedArmor = [self.armors objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    if ([[segue identifier] isEqualToString:@"armorDetail"]) {
        DDNArmorDetailViewController *detailVC = [segue destinationViewController];
        detailVC.armor = self.selectedArmor;
    }
}

#pragma mark - Table view data source

- (void)fetchArmor {
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Armor" inManagedObjectContext:_managedObjectContext];
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    // Define how we will sort the records
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:sortDescriptors];
    
    // Fetch the records and handle an error
    NSError *error;
    NSMutableArray *mutableFetchResults = [[_managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (!mutableFetchResults) {
        // Handle the error.
        // This is a serious error and should advise the user to restart the application
    }
    // Save our fetched data to an array
    self.armors = mutableFetchResults;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.armors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [[self.armors objectAtIndex:indexPath.row] name];
    
    return cell;
}

@end
