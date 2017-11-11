//
//  Aaaaa.m
//  work
//
//  Created by mac on 2017/11/11.
//  Copyright © 2017年 pc. All rights reserved.
//

#import "Aaaaa.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "GZWTool.h"
#import "GzwHUDTool.h"
@interface Aaaaa ()
@property (weak, nonatomic) IBOutlet UILabel *titleText;
@property (weak, nonatomic) IBOutlet UILabel *dec;

@end

@implementation Aaaaa

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"兼职详情";
    
//    self.titleText.text = @"这一句在iOS8上+作为的英文";
//    self.dec.text = @"但是iOS7的兼容就显得蛋疼许多了，主要是由于，iOS7使用的UITableView要一定实现heightForRowAtIndexPath代理方法，这里你可能会觉得，那我们实现这个代理方法，报道查看UITableViewAutomaticDimension就好了啊，的遗憾的英文UITableViewAutomaticDimension在iOS7里面也是不可用的，不信你可以试一下，直接崩溃但是iOS7的兼容就显得蛋疼许多了，主要是由于，iOS7使用的UITableView要一定实现heightForRowAtIndexPath代理方法，这里你可能会觉得，那我们实现这个代理方法，报道查看UITableViewAutomaticDimension就好了啊，的遗憾的英文UITableViewAutomaticDimension在iOS7里面也是不可用的，不信你可以试一下，直接崩溃";
    
    self.titleText.text = self.model.title;
    self.dec.text = self.model.dec;
    self.tableView.estimatedRowHeight = 56;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}
- (IBAction)fff:(id)sender {
    [GzwHUDTool showWithStatus:nil];
    [@"" gzw_performAfter:2 block:^{
        [GzwHUDTool showSuccessWithStatus:@"提交成功"];
    }];
}

-(void)setModel:(HomeModel *)model
{
    _model = model;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}


@end
