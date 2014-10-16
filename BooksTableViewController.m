//
//  BooksTableViewController.m
//  Bookify
//
//  Created by Aniket Bochare on 10/8/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import "BooksTableViewController.h"
#import "BookListItem.h"
#import "PagesTableViewController.h"
#import "PageListItem.h"
#import "DataModel.h"


@interface BooksTableViewController ()

@end


@implementation BooksTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //Making self delegate so that this controller gets messages for state of navigation controller.
    
    self.navigationController.delegate = self;
    //Works better to get information about objects updated from detail view controller than setting up delegates; eg: Getting incomplete count after updates.
    
    [self.tableView reloadData];
    //Getting default values saved if app was terminated ever.
    
    NSInteger index = [self.dataModel indexOfSelectedBook];
    //If it was terminated it will have index of table and hence we check for non -1 value here.
    
    if (index>=0 && index< self.dataModel.books.count)
    {
        BookListItem *book = self.dataModel.books[index];
        [self performSegueWithIdentifier:@"ShowPages" sender:book];
    }
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataModel.books count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        }
    
    BookListItem *book = self.dataModel.books[indexPath.row];
    cell.textLabel.text = book.BookTitle;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    int incompleteCount = [book countIncompletePages];
    
    if ([book.pages count] == 0)
        {
            cell.detailTextLabel.text = @"No Pages!";
        }
    else if (incompleteCount ==0)
        {
            cell.detailTextLabel.text = @"Done!";
        }
    else
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Incomplete", [book countIncompletePages]];
        }

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Adding to remember screen when apps gets terminated and user is back to same place when it is launched.
    [self.dataModel setIndexOfSelectedBook:indexPath.row];
    BookListItem *book = self.dataModel.books[indexPath.row];
    [self performSegueWithIdentifier:@"ShowPages" sender:book];
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.dataModel.books removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = @[indexPath];
   // [self savePageListItems];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"ShowPages"])
    {
        PagesTableViewController *controller = segue.destinationViewController;
        controller.selectedBook = sender;
    }
    else if ([segue.identifier isEqualToString:@"AddBook"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        BookDetailViewController *controller = (BookDetailViewController*)navigationController.topViewController;
        controller.delegate = self;
        controller.bookToEdit = nil;
    }
    
}

#pragma BookDetailViewControllerDelegate Methods


- (void)bookDetailViewControllerDidCancel: (BookDetailViewController *)controller
{
    NSLog(@"Calledhere");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)bookDetailViewController: (PageDetailViewController *)controller didFinishAddingBook:(BookListItem*)book
{
    
    NSInteger lastRowIndex = [self.dataModel.books count];
    [self.dataModel.books addObject:book];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRowIndex inSection:0];
    //Add the indexpaths to the array as we can add multiple rows.
    NSArray *indexPaths = @[indexPath];
    
    //This funtion is important as it calls the delegate functions to create row view at NSIndexpath and redraws the cell. Use this always for adding row to a table view.
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    //Sorting only happens here and editing book
    
    [self.dataModel sortBookLists];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)bookDetailViewController: (BookDetailViewController *)controller didFinishEditingBook:(BookListItem *)book
{
    
    NSInteger editBookIndex = [self.dataModel.books indexOfObject:book];
    NSIndexPath *editIndexPath = [NSIndexPath indexPathForRow:editBookIndex inSection:0];
    UITableViewCell *editCell = [self.tableView cellForRowAtIndexPath:editIndexPath];
    editCell.textLabel.text =book.BookTitle;
    [self.dataModel sortBookLists];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //Creating segue manually instead of using storyboard.
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditBookNavigationController"];
    
    BookDetailViewController *bookDetailViewController = (BookDetailViewController*) navigationController.topViewController;
    bookDetailViewController.delegate =self;
    BookListItem *book = self.dataModel.books[indexPath.row];
    bookDetailViewController.bookToEdit = book;
    
    //Presenting navigation controller programatically
    NSLog(@"Calling present");
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

//Implementing the navigation controller delegate to handle back events and save an index which is not in range for array (0 to n-1)
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self)
    {
        [self.dataModel setIndexOfSelectedBook:-1];;
    }
}



@end
