//
//  GameResultCell.m
//  work
//
//  Created by 林海 on 17/8/16.
//  Copyright © 2017年 pc. All rights reserved.
//

#import "GameResultCell.h"

@interface GameResultCell()

@end

@implementation GameResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titelText.layer.borderColor = KRGB(252, 202, 95, 1).CGColor;
    self.titelText.layer.borderWidth = 3;
    self.titelText.layer.cornerRadius = 4;
    self.titelText.clipsToBounds = YES;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
}

+(instancetype)cellWithTableView:(UITableView *)tableview
{
    GameResultCell *cell = [tableview dequeueReusableCellWithIdentifier:@"ssdd"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GameResultCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
@end
