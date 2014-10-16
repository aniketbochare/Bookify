//
//  PageDetailViewController.m
//  Bookify
//
//  Created by Aniket Bochare on 10/5/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import "PageDetailViewController.h"
#import "PageListItem.h"

@interface PageDetailViewController ()

@end

@implementation PageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.pageToEdit != nil)
    {
        self.title = @"Edit Item";
        self.PageTitle.text = self.pageToEdit.PageTitle;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.PageTitle becomeFirstResponder];
}

- (IBAction)cancel
{
    [self.delegate pageDetailViewControllerDidCancel:self];
}

- (IBAction)done
{
    if (self.pageToEdit.PageTitle)
    {
        self.pageToEdit.PageTitle = self.PageTitle.text;
        [self.delegate pageDetailViewController:self didFinishEditingPage:self.pageToEdit];
    }
    else
    {
    PageListItem *newpage = [[PageListItem alloc] init];
    newpage.PageTitle = self.PageTitle.text;
    newpage.checked = NO;
    
    [self.delegate pageDetailViewController:self didFinishAddingPage:newpage];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
self.doneBarButton.enabled = ([newText length] > 0);
return YES;
}

@end
