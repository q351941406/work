//
//  ZhiWuTBVC.m
//  work
//
//  Created by 林海 on 17/8/23.
//  Copyright © 2017年 pc. All rights reserved.
//

#import "ZhiWuTBVC.h"
#import "HomeModel.h"
#import "FHHomeCell.h"
#import <AXWebViewController/AXWebViewController.h>
#import "AppDelegate.h"
#import "Aaaaa.h"

@interface ZhiWuTBVC ()
@property (nonatomic,strong) NSMutableArray *myDatas;
@end

@implementation ZhiWuTBVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.myDatas = [NSMutableArray array];
    
    self.tableView.rowHeight = 140;

    
    NSMutableArray *ary = [NSMutableArray array];
    
    for (int i = 0; i < self.datas.count; i++) {
        HomeModel *model = self.datas[i];
        if (model.zhi_ID == self.type + 1) {
            [self.myDatas addObject:model];
        }else{
            [ary addObject:model];
        }
    }
    
    [self.myDatas addObjectsFromArray:[ary copy]];

}

#pragma mark - tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myDatas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeModel *model = self.myDatas[indexPath.row];
    model.row = indexPath.row;
    FHHomeCell *cell = [FHHomeCell cellWithTableView:tableView];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HomeModel *model = self.myDatas[indexPath.row];
    
    AppDelegate *a = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (!a.pass) {
        AXWebViewController *web = [[AXWebViewController alloc] initWithURL:[NSURL URLWithString:model.URL]];
//        [self.navigationController pushViewController:web animated:YES];
        
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Aaaaa" bundle:nil];
        Aaaaa *vc = sb.instantiateInitialViewController;
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"要使用此功能请先咨询客服" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
        
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.URL]];
    }
}

@end
