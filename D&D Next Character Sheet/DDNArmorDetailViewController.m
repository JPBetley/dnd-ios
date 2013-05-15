//
//  DDNArmorDetailViewController.m
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/13/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import "DDNArmorDetailViewController.h"
#import "DDNDetailViewController.h"

@interface DDNArmorDetailViewController ()
    enum {
        ARMOR_CLASS,
        WEIGHT,
        PRICE,
        TYPE,
        SPEED
    };
@end

@implementation DDNArmorDetailViewController

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
    self.navigationItem.title = self.armor.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"doneArmor"]) {
        DDNDetailViewController *detailVC = segue.destinationViewController;
        detailVC.character.armor = self.armor;
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
        case ARMOR_CLASS:
            cell.textLabel.text = @"Armor Class";
            cell.detailTextLabel.text = self.armor.ac.description;
            break;
        case WEIGHT:
            cell.textLabel.text = @"Weight";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ lbs", self.armor.weight];
            break;
        case PRICE:
            cell.textLabel.text = @"Price";
            cell.detailTextLabel.text = self.armor.price;
            break;
        case TYPE:
            cell.textLabel.text = @"Type";
            cell.detailTextLabel.text = self.armor.type;
            break;
        case SPEED:
            cell.textLabel.text = @"Speed";
            cell.detailTextLabel.text = self.armor.speed;
            break;
        default:
            break;
    }
    
    return cell;
}

@end
