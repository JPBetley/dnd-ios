//
//  DDNWeaponDetailViewController.m
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/12/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import "DDNWeaponDetailViewController.h"

@interface DDNWeaponDetailViewController ()

@end

@implementation DDNWeaponDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.nameLabel.text = self.weapon.name;
    self.damageLabel.text = self.weapon.damage;
    self.priceLabel.text = self.weapon.price;
    self.typeLabel.text = self.weapon.type;
    self.propertiesLabel.text = self.weapon.properties;
    self.weightLabel.text = self.weapon.weight.description;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
