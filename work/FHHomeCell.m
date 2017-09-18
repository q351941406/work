//
//  FHHomeCell.m
//  work
//
//  Created by 林海 on 17/8/10.
//  Copyright © 2017年 pc. All rights reserved.
//

#import "FHHomeCell.h"
#import "HomeModel.h"
#import "GzwThemeTool.h"


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

    
    self.title.layer.shadowColor =  [UIColor blackColor].CGColor;
    self.title.layer.shadowOffset =  CGSizeMake(1,1);
    
    //self.miaoshu.hidden
    
    NSArray *array = @[[GzwThemeTool theme],[UIColor whiteColor]];
    self.backView.backgroundColor =  RandomFlatColorExcluding(array);
//        self.backView.backgroundColor =  RandomFlatColorWithShade(UIShadeStyleLight);
    
    self.backView.backgroundColor = [UIColor colorWithGradientStyle:0 withFrame:CGRectMake(0, 0, 500, 500) andColors:@[
//                                                                                                                       HexColor(@"f54ea2"),
//                                                                                                                       HexColor(@"ff7676"),
//                                                                                                                       HexColor(@"fce38a"),
//                                                                                                                       HexColor(@"f38181")
                                                                                                                       HexColor(@"17ead9"),
                                                                                                                       HexColor(@"6078ea")
                                                                                                                       ]];
    
    _title.textColor = ContrastColor(self.backView.backgroundColor, YES);
    _title.textColor = [UIColor whiteColor];
    _subTitle.textColor = _title.textColor;
    _desTitle.textColor = _title.textColor;
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

    
}


@end
