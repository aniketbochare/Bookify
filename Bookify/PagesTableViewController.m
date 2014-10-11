//
//  PagesTableViewController.m
//  Bookify
//
//  Created by Aniket Bochare on 10/4/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import "PagesTableViewController.h"
#import "PageListItem.h"
#import "PageDetailViewController.h"
#import "BookListItem.h"

@interface PagesTableViewController ()

@end

@implementation PagesTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.selectedBook.BookTitle;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.selectedBook.pages count];
    
}


- (void)configureCheckmarkForCell:(UITableViewCell *)cell withPage:(PageListItem *)page
{
    UILabel *label = (UILabel *)[cell viewWithTag:1001];
    
    if (page.checked) {
        label.text = @"√";
    } else {
        label.text = @"";
    }
}


- (void)configureTextForCell:(UITableViewCell *)cell withPage:(PageListItem *)page
{
    
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = page.PageTitle;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     NSLog(@"Inside return cell");
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PageListCell" forIndexPath:indexPath];
    PageListItem *page = self.selectedBook.pages[indexPath.row];
    [self configureCheckmarkForCell:cell withPage:page];
    [self configureTextForCell:cell withPage:page];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    PageListItem *page = self.selectedBook.pages[indexPath.row];
    page.checked = !page.checked;
    [self configureCheckmarkForCell:cell withPage:page];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.selectedBook.pages removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //NSLog(segue.identifier);
    
    if ([segue.identifier isEqualToString:@"AddPage"]) {
        
        NSLog(@"Inside If");
        // 1 the destination view controller here does not connect to viewcontroller but to the navigation controller.
        UINavigationController *navigationController = segue.destinationViewController;
        
        // 2 Get the reference of the view controller from top view controller of the navigation controller and then cast it to match the addpageview controller.
        PageDetailViewController *controller = (PageDetailViewController *) navigationController.topViewController;
        
        //3 Assign self as the delegate to get messages from AddViewController if anything happens.
        controller.delegate = self;
        
        
    }
    else if ([segue.identifier isEqualToString:@"EditPage"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        PageDetailViewController *controller = (PageDetailViewController *) navigationController.topViewController;
        controller.delegate = self;
        NSLog(@"Assigned Delegate");
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.pageToEdit = self.selectedBook.pages[indexPath.row];
    }
    
}


#pragma PageDetailViewControllerDelegate Methods


- (void)pageDetailViewControllerDidCancel: (PageDetailViewController *)controller
{
    NSLog(@"Calledhere");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pageDetailViewController: (PageDetailViewController *)controller didFinishAddingPage:(PageListItem*)page{
    
    //Get last row Index for addition
    NSInteger lastRowIndex = [self.selectedBook.pages count];
    
    //Add Page to the _pages instance variable.
    [self.selectedBook.pages addObject:page];
    
    //Get Index path for the index last row.
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRowIndex inSection:0];
    //Add the indexpaths to the array as we can add multiple rows.
    NSArray *indexPaths = @[indexPath];
    
    //This funtion is important as it calls the delegate functions to create row view at NSIndexpath and redraws the cell. Use this always for adding row to a table view.
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
  //  [self savePageListItems];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)pageDetailViewController: (PageDetailViewController *)controller didFinishEditingPage:(PageListItem*)page{
    
    NSInteger editPageIndex = [self.selectedBook.pages indexOfObject:page];
    NSIndexPath *editIndexPath = [NSIndexPath indexPathForRow:editPageIndex inSection:0];
    
    //Get that cell with this indexpath
    
    UITableViewCell *editCell = [self.tableView cellForRowAtIndexPath:editIndexPath];
    
    [self configureTextForCell:editCell withPage:page];
    
 //   [self savePageListItems];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


@end
