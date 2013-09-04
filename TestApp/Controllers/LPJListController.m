//
//  LPJListController.m
//  TestApp
//
//  Created by Leonardo Parro Jr on 9/3/13.
//  Copyright (c) 2013 Leonardo Parro Jr. All rights reserved.
//

#import "LPJListController.h"
#import "LPJListCell.h"


@interface LPJListController ()

@property (nonatomic, weak) IBOutlet UITableView *aTableView;
@property (nonatomic, strong) NSMutableArray *aListData;

- (void)getFactsAPI;
@end

///////////////////////////////////////////////////////////////////////////////
@implementation LPJListController

///////////////////////////////////////////////////////////////////////////////
#pragma mark - View Cycle Handlers
///////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.aListData = [[NSMutableArray alloc] init];
    
    SCNetworkReachability *reachability = [SCNetworkReachability reachabilityWithHostName:kAPIBaseURLString];
    if (reachability.status == SCNetworkStatusNotReachable) {
        //[[Global sharedInstance] showAlert:@"Error" message:@"No internet connection."];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No internet connection."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        [self getFactsAPI];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark - Low Memory Handler
///////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && self.view.window == nil) {
        self.view = nil;
    }
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource
///////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.aListData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LPJListCellIdentifier";
    LPJListCell *cell = (LPJListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    [cell bindData:self.aListData[indexPath.row]];
    
    return cell;
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate
///////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 118.0f;
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark - API Calls
///////////////////////////////////////////////////////////////////////////////
- (void)getFactsAPI
{    
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
    NSURLRequest *request = [[LPHTTPClient sharedClient]
                             requestWithMethod:@"GET" path:@"/facts.json" parameters:nil];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSDictionary *dResponse = (NSDictionary *)JSON;
        if (dResponse) {
            [self.aListData removeAllObjects];
            [self.aListData addObjectsFromArray:[dResponse valueForKeyPath:@"rows"]];
            self.title = (NSString *)[dResponse valueForKeyPath:@"title"];
            [self.aTableView reloadData];
        }
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"error: %@", [error localizedDescription]);
        [SVProgressHUD dismiss];
    }];
    
    [operation start];
}

@end
