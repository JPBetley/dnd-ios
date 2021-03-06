//
//  DDNGearViewController.m
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/13/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import "DDNGearViewController.h"
#import "DDNGearListViewController.h"

@interface DDNGearViewController ()

@end

@implementation DDNGearViewController

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
    self.gear = [NSMutableArray arrayWithArray:self.character.gear.allObjects];
    
    // Add edit item to bar button items
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.navigationItem.rightBarButtonItem, self.editButtonItem, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)selectGear:(UIStoryboardSegue *)segue {
    self.gear = [NSMutableArray arrayWithArray:self.character.gear.allObjects];
    [self.tableView reloadData];
}

-(IBAction)cancelGear:(UIStoryboardSegue *)segue {
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"detailGear"]) {
        DDNGearListViewController *listVC = [segue destinationViewController];
        listVC.character = self.character;
        listVC.managedObjectContext = self.managedObjectContext;
    }
}

#pragma mark - Table view data source

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
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ lbs", gear.weight];
    
    return cell;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self.gear removeObjectAtIndex:indexPath.row];
        self.character.gear = [NSSet setWithArray:self.gear];
        NSError *error;
        if(![self.managedObjectContext save:&error]){
            NSLog(@"[ERROR] COREDATA: Save raised an error - '%@'", [error description]);
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
