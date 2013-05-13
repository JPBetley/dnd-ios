//
//  DDNWeaponDetailViewController.h
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/12/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weapon.h"

@interface DDNWeaponDetailViewController : UIViewController

@property (strong, nonatomic) Weapon *weapon;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *damageLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *propertiesLabel;

@end
