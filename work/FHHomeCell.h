//
//  FHHomeCell.h
//  work
//
//  Created by 林海 on 17/8/10.
//  Copyright © 2017年 pc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeModel;
@interface FHHomeCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) HomeModel *model;
@end
