//
//  DDNGearListViewController.m
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/13/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import "DDNGearListViewController.h"
#import "DDNGearViewController.h"

@interface DDNGearListViewController ()

@end

@implementation DDNGearListViewController

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
    [self fetchGear];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"selectGear"]) {
        Gear *gear = [self.gear objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        [self.character addGearObject:gear];
        NSError *error;
        if(![self.managedObjectContext save:&error]){
            NSLog(@"[ERROR] COREDATA: Save raised an error - '%@'", [error description]);
        }
    }
}

#pragma mark - Table view data source

- (void)fetchGear {
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Gear" inManagedObjectContext:_managedObjectContext];
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
    self.gear = mutableFetchResults;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.gear count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Gear *gear = [self.gear objectAtIndex:indexPath.row];
    cell.textLabel.text = gear.name;
    cell.detailTextLabel.text = gear.price;
    
    return cell;
}

@end
