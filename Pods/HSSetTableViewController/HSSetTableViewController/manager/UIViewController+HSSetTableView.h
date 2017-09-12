//
//  UIViewController+HSSetTableView.h
//  HSSetTableViewCtrollerDemo
//
//  Created by hushaohui on 2017/7/24.
//  Copyright © 2017年 ZLHD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HSBaseCellModel;
@interface UIViewController (HSSetTableView)

@property (nonatomic, strong)UITableView *hs_tableView;  ///<表视图
@property (nonatomic, strong)NSMutableArray *hs_dataArry;  ///<数据源



/**
  初始化tableViewConfigure  section footer和height均是为默认
 */
- (void)initSetTableViewConfigure;

/**
 初始化tableViewConfigure

 @param footerViewArry footer 数组
 @param footerHeightArry footer高度数组
 */
- (void)initSetTableViewConfigureWithSectionFooter:(NSArray <UIView *> *)footerViewArry footerHeight:(NSArray<NSNumber *> *)footerHeightArry;

/**
 更新cell模型方法
 
 @param cellModel model
 */
- (void)updateCellModel:(HSBaseCellModel *)cellModel;


/**
 更新cell模型方法
 
 @param cellModel model
 @param animation 动画效果
 */
- (void)updateCellModel:(HSBaseCellModel *)cellModel animation:(UITableViewRowAnimation)animation;

@end
