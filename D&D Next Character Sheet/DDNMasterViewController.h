//
//  DDNMasterViewController.h
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/10/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedFetcher.h"
#import <CoreData/CoreData.h>

@interface DDNMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) FeedFetcher *feedFetcher;

-(IBAction)done:(UIStoryboardSegue *)sender;
-(IBAction)cancel:(UIStoryboardSegue *)sender;

@end
