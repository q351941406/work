//
//  FHHomeCell.m
//  work
//
//  Created by 林海 on 17/8/10.
//  Copyright © 2017年 pc. All rights reserved.
//

#import "FHHomeCell.h"
#import "HomeModel.h"

@interface FHHomeCell()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *backImg;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *desTitle;
@property (weak, nonatomic) IBOutlet UILabel *miaoshu;

@end

@implementation FHHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.shadowColor =  [UIColor blackColor].CGColor;
    self.backView.layer.shadowOffset =  CGSizeMake(3,3);
    self.backView.layer.shadowOpacity = 0.3;
    
    self.backImg.clipsToBounds = YES;
    
    self.title.layer.shadowColor =  [UIColor blackColor].CGColor;
    self.title.layer.shadowOffset =  CGSizeMake(1,1);
    
    //self.miaoshu.hidden
    
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    FHHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FHHomeCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

-(void)setModel:(HomeModel *)model
{
    _model = model;
    _title.text = model.title;
    _subTitle.text = model.subtitle;
    _desTitle.text = [NSString stringWithFormat:@"%ld人在做",(long)model.count+model.chose_count];
    
    NSString *name = [NSString stringWithFormat:@"%ld",(model.row % 17) + 1];
    _backImg.image = [UIImage imageNamed:name];
}


@end
