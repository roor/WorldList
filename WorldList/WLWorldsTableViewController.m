//
//  WLWorldsTableViewController.m
//  WorldList
//
//  Created by Artem Podustov on 7/28/15.
//  Copyright (c) 2015 OLEArt. All rights reserved.
//

#import "WLWorldsTableViewController.h"
#import "WLLoginViewController.h"
#import "WLServerClient.h"
#import "WLWorld.h"

@interface WLWorldsTableViewController () <WLLoginViewControllerDelegate>
@property (strong, nonatomic) NSArray *dataSource;
@end

@implementation WLWorldsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.dataSource == nil) {
        WLLoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WLLoginViewController"];
        loginVC.delegate = self;
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.dataSource count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    WLWorld *item = self.dataSource[indexPath.row];
    
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.worldStatus;
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)loginDidClicked:(WLLoginViewController *)loginViewController withLogin:(NSString *)login andPassword:(NSString *)password {
    
    [[WLServerClient sharedInstance] loginWith:login andPassword:password callback:^(NSArray *data, NSError *error) {
        if (!error) {
            
            self.dataSource = data;
            
            [self.tableView reloadData];
            
            [loginViewController dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

@end
