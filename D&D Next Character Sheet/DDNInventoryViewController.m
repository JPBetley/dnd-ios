//
//  DDNInventoryViewController.m
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/10/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import "DDNInventoryViewController.h"
#import "DDNWeaponViewController.h"
#import "Armor.h"
#import "Gear.h"
#import "Weapon.h"

@interface DDNInventoryViewController ()
@property UITextField *textField;
@end

@implementation DDNInventoryViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"weapon"]) {
        [((DDNWeaponViewController *)[segue destinationViewController]) setSelectedRow:self.tableView.indexPathForSelectedRow.row];
    }
    if ([[segue destinationViewController] respondsToSelector:@selector(setCharacter:)]) {
        [[segue destinationViewController] performSelector:@selector(setCharacter:) withObject:self.character];
    }
    if ([[segue destinationViewController] respondsToSelector:@selector(setManagedObjectContext:)]) {
        [[segue destinationViewController] performSelector:@selector(setManagedObjectContext:) withObject:self.managedObjectContext];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    self.textField = textField;
}

-(void)cancelNumberPad {
    [self.textField resignFirstResponder];
}

-(void)updateGp:(id)sender {
    self.character.gp = [NSNumber numberWithDouble:self.textField.text.doubleValue];
    [self.textField resignFirstResponder];
}

-(void)updateSp:(id)sender {
    self.character.sp = [NSNumber numberWithDouble:self.textField.text.doubleValue];
    [self.textField resignFirstResponder];
}

-(void)updateCp:(id)sender {
    self.character.cp = [NSNumber numberWithDouble:self.textField.text.doubleValue];
    [self.textField resignFirstResponder];
}

-(void)updateExperience:(id)sender {
    self.character.experience = [NSNumber numberWithDouble:self.textField.text.doubleValue];
    [self.textField resignFirstResponder];
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
    switch (section) {
        case 0:
            return 2;
        case 1:
            return 1;
        case 2:
            return 1;
        case 3:
            return 3;
        case 4:
            return 1;
            
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text;
    NSString *detailText;
    NSString *cellIdentifier;
    switch (indexPath.section) {
        case 0: // Weapons
            cellIdentifier = @"weapon";
            NSUInteger count = [self.character.weapons count];
            NSInteger row = indexPath.row;
            if (count < row + 1) {
                text = @"Weapon";
                detailText = @"None";
            } else {
                Weapon *weapon = [[self.character.weapons allObjects] objectAtIndex:indexPath.row];
                text = weapon.name;
                detailText = weapon.damage;
            }
            break;
        case 1: // Armor
            cellIdentifier = @"armor";
            if (self.character.armor) {
                text = self.character.armor.name;
                detailText = [NSString stringWithFormat:@"%@ AC", self.character.armor.ac];
            } else {
                text = @"Armor";
                detailText = @"None";
            }
            break;
        case 2: // Gear
            cellIdentifier = @"gear";
            text = @"Gear";
            break;
        case 3: // Money
        {
            cellIdentifier = @"money";
            UITableViewCell *moneyCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            UILabel *moneyLabel = (UILabel *)[moneyCell viewWithTag:2];
            UITextField *moneyText = (UITextField *)[moneyCell viewWithTag:1];
            SEL action;
            switch (indexPath.row) {
                case 0:
                    moneyLabel.text = @"Gold Pieces";
                    moneyText.text = self.character.gp.description;
                    action = @selector(updateGp:);
                    break;
                case 1:
                    moneyLabel.text = @"Silver Pieces";
                    moneyText.text = self.character.sp.description;
                    action = @selector(updateSp:);
                    break;
                case 2:
                    moneyLabel.text = @"Copper Pieces";
                    moneyText.text = self.character.cp.description;
                    action = @selector(updateCp:);
                    break;
                default:
                    action = @selector(cancelNumberPad);
                    break;
            }
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = [NSArray arrayWithObjects:
                                   [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:action],
                                   nil];
            [numberToolbar sizeToFit];
            moneyText.inputAccessoryView = numberToolbar;
            moneyText.delegate = self;
            return moneyCell;
        }
        case 4:
        {
            cellIdentifier = @"money";
            UITableViewCell *moneyCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            UILabel *moneyLabel = (UILabel *)[moneyCell viewWithTag:2];
            UITextField *moneyText = (UITextField *)[moneyCell viewWithTag:1];
            moneyLabel.text = @"Experience";
            moneyText.text = self.character.experience.description;
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = [NSArray arrayWithObjects:
                                   [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(updateExperience:)],
                                   nil];
            [numberToolbar sizeToFit];
            moneyText.inputAccessoryView = numberToolbar;
            moneyText.delegate = self;
            return moneyCell;
        }
        default:
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = text;
    cell.detailTextLabel.text = detailText;

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
