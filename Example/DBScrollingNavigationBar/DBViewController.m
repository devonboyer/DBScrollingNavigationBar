//
//  DBViewController.m
//  DBScrollingNavigationBar
//
//  Created by Devon Boyer on 06/12/2015.
//  Copyright (c) 2014 Devon Boyer. All rights reserved.
//

#import "DBViewController.h"

#import <DBScrollingNavigationBar/DBScrollingNavigationBar.h>

@interface DBViewController () <UIScrollViewDelegate>

@end

@implementation DBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    // Configure Navigation Bar
    self.navigationItem.title = @"DBScrollingNavigationBar";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:66/255.0 green:133/255.0 blue:244/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 18;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.navigationController scrollViewDidScroll:scrollView];
    [self.tabBarController scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.navigationController scrollViewDidEndDecelerating:scrollView];
    [self.tabBarController scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.navigationController scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    [self.tabBarController scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

@end
