//
//  GameColorVC.h
//  work
//
//  Created by 林海 on 17/8/11.
//  Copyright © 2017年 pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface GameColorVC : UIViewController <UIAlertViewDelegate>
@property (nonatomic,copy) NSString *jinbi_count;
@property (nonatomic,copy) void(^viewDidDissMss)(NSInteger jinbi_count);
@end
