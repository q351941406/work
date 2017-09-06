//
//  GameResultCell.h
//  work
//
//  Created by 林海 on 17/8/16.
//  Copyright © 2017年 pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameResultCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableview;
@property (weak, nonatomic) IBOutlet UILabel *titelText;

@end
