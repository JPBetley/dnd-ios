//
//  DDNBlogViewController.m
//  D&D Next Character Sheet
//
//  Created by Tatsumori on 5/14/13.
//  Copyright (c) 2013 JPBetley. All rights reserved.
//

#import "DDNBlogViewController.h"

@interface DDNBlogViewController ()

@end

@implementation DDNBlogViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)feedFetcher:(FeedFetcher *)feedFetcher didLoadFeed:(NSMutableArray *)array {
    self.articles = array;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [[self.articles objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [[self.articles objectAtIndex:indexPath.row] objectForKey:@"pubDate"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *url = [[[self.articles objectAtIndex:indexPath.row] objectForKey:@"link"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *cleanurl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Opening URL: %@", cleanurl);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:cleanurl]];
}

@end
