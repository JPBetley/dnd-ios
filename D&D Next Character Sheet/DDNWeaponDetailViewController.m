//
//  DDNWeaponDetailViewController.m
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/12/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import "DDNWeaponDetailViewController.h"
#import "DDNDetailViewController.h"


@interface DDNWeaponDetailViewController ()
    enum {
        DAMAGE = 0,
        WEIGHT,
        PRICE,
        TYPE,
        PROPERTIES
    };
@end

@implementation DDNWeaponDetailViewController

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
	// Do any additional setup after loading the view.
    self.navigationItem.title = self.weapon.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"doneWeapon"]) {
        DDNDetailViewController *detailVC = segue.destinationViewController;
        NSMutableArray *weapons = [NSMutableArray arrayWithArray:detailVC.character.weapons.allObjects];
        if ([weapons count] > self.selectedRow) {
            [weapons replaceObjectAtIndex:self.selectedRow withObject:self.weapon];
        } else {
            [weapons addObject:self.weapon];
        }
        detailVC.character.weapons = [NSSet setWithArray:weapons];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    switch (indexPath.section) {
        case DAMAGE:
            cell.textLabel.text = @"Damage";
            cell.detailTextLabel.text = self.weapon.damage;
            break;
        case WEIGHT:
            cell.textLabel.text = @"Weight";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ lbs", self.weapon.weight];
            break;
        case PRICE:
            cell.textLabel.text = @"Price";
            cell.detailTextLabel.text = self.weapon.price;
            break;
        case TYPE:
            cell.textLabel.text = @"Type";
            cell.detailTextLabel.text = self.weapon.type;
            break;
        case PROPERTIES:
            cell.textLabel.text = @"Properties";
            cell.detailTextLabel.text = self.weapon.properties;
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

@end
