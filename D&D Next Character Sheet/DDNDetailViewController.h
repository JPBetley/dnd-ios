//
//  DDNDetailViewController.h
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/10/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDNDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
