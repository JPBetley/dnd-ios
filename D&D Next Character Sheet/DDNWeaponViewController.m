//
//  DDNWeaponViewController.m
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/12/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import "DDNWeaponViewController.h"
#import "DDNWeaponDetailViewController.h"

@interface DDNWeaponViewController ()

@end

@implementation DDNWeaponViewController

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
    [self fetchWeapons];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.selectedWeapon = [self.weapons objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    if ([[segue identifier] isEqualToString:@"weaponDetail"]) {
        DDNWeaponDetailViewController *detailVC = [segue destinationViewController];
        detailVC.weapon = self.selectedWeapon;
        detailVC.selectedRow = self.selectedRow;
    }
    if ([[segue identifier] isEqualToString:@"doneWeapon"]) {
        [self.character addWeaponsObject:self.selectedWeapon];
    }
}

#pragma mark - Table view data source

- (void)fetchWeapons {
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Weapon" inManagedObjectContext:_managedObjectContext];
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
    self.weapons = mutableFetchResults;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.weapons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Weapon *weapon = [self.weapons objectAtIndex:indexPath.row];
    cell.textLabel.text = weapon.name;
    
    return cell;
}

#pragma mark - Table view delegate

@end
