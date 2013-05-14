//
//  DDNBlogViewController.h
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/14/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedFetcher.h"

@interface DDNBlogViewController : UITableViewController <FeedFetcherDelegate>

@property (nonatomic, strong) NSArray *articles;
@property (nonatomic, strong) FeedFetcher *feedFetcher;

@end
