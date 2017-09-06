//
//  SYProgressHUD.m
//  SYHUDView
//
//  Created by Saucheong Ye on 8/12/15.
//  Copyright © 2015 sauchye.com. All rights reserved.
//

#define kCURRENT_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define kCURRENT_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kKeyWindows [UIApplication sharedApplication].keyWindow
#define kHudFont(fontSize) [UIFont systemFontOfSize:fontSize]
#define kAllocProgressHUD [SYProgressHUD showHUDAddedTo:kKeyWindows animated:YES]
#define Image(imageName) [UIImage imageNamed:imageName]
#define kHudDetailFontSize 14.0
#define kHudFontSize 15.0
#define MIN_WIDTH 130.0f

#import "SYProgressHUD.h"

static CGFloat const delyedTime = 2.5;
static CGFloat const margin = 10.0f;

@implementation SYProgressHUD

+ (void)showStatus:(SYProgressHUDStatus)status
              text:(NSString *)text
              hide:(NSTimeInterval)time{
    [self showStatus:status text:text toView:nil];
   
}

+(void)showStatus:(SYProgressHUDStatus)status text:(NSString *)text toView:(UIView *)toView
{
    SYProgressHUD *hud = kAllocProgressHUD;
    [hud showAnimated:YES];
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.label.text = @" ";
    hud.detailsLabel.font = kHudFont(kHudFontSize);
    hud.detailsLabel.text = text;
    hud.label.font = kHudFont(kHudFontSize);
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud setMinSize:CGSizeMake(MIN_WIDTH, MIN_WIDTH)];
    if (toView) {
        [toView addSubview:hud];
    }else{
        [kKeyWindows addSubview:hud];
    }
 
    NSTimeInterval time = 1.5;
    switch (status) {
            
        case SYProgressHUDStatusSuccess: {
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *successView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_success"]];
            hud.customView = successView;
            [hud hideAnimated:YES afterDelay:time];
        }
            break;
            
        case SYProgressHUDStatusFailure: {
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *errorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_error"]];
            hud.customView = errorView;
            [hud hideAnimated:YES afterDelay:time];
        }
            break;
            
        case SYProgressHUDStatusInfo: {
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *infoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_info"]];
            hud.customView = infoView;
            [hud hideAnimated:YES afterDelay:time];
        }
            break;
            
        case SYProgressHUDStatusLoading:{
            hud.mode = MBProgressHUDModeIndeterminate;
        }
            break;
            
        default:
            break;
    }
}

+ (void)showSuccessText:(NSString *)text{
    
    [self showStatus:SYProgressHUDStatusSuccess text:text hide:delyedTime];
}

+ (void)showFailureText:(NSString *)text{
    
    [self showStatus:SYProgressHUDStatusFailure text:text hide:delyedTime];
}

+ (void)showInfoText:(NSString *)text{
    
    [self showStatus:SYProgressHUDStatusInfo text:text hide:delyedTime];
}

+ (void)showLoadingWindowText:(NSString *)text{
    
    [self showStatus:SYProgressHUDStatusLoading text:text hide:delyedTime];
}

+ (void)hide{
    
    [SYProgressHUD hideHUDForView:kKeyWindows animated:NO];
}

+ (void)hideToView:(UIView *)view{
    
    [SYProgressHUD hideHUDForView:view animated:NO];
}

+(void)showLoadingWindowText:(NSString *)text View:(UIView *)view
{
    SYProgressHUD *hud = kAllocProgressHUD;
    [hud showAnimated:YES];
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.label.text = text;
    hud.label.font = kHudFont(kHudFontSize);
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud setMinSize:CGSizeMake(MIN_WIDTH, MIN_WIDTH)];
    hud.mode = MBProgressHUDModeIndeterminate;
    [view addSubview:hud];
}


+ (SYProgressHUD *)showToLoadingView:(UIView *)view{
    SYProgressHUD *hud = [SYProgressHUD showHUDAddedTo:view animated:YES];
    [view addSubview:hud];
    hud.label.font = kHudFont(kHudDetailFontSize);
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud setMinSize:CGSizeMake(MIN_WIDTH, MIN_WIDTH)];
    return hud;
}

+ (SYProgressHUD *)showToCenterText:(NSString *)text{
    
    SYProgressHUD *hud = kAllocProgressHUD;
    [kKeyWindows addSubview:hud];
    hud.detailsLabel.font = kHudFont(kHudDetailFontSize);
    hud.detailsLabel.text = text;
    hud.mode = MBProgressHUDModeText;
    hud.margin = margin;
    hud.removeFromSuperViewOnHide = YES;
    hud.animationType = MBProgressHUDAnimationZoom;
    [hud hideAnimated:YES afterDelay:delyedTime];
    return hud;
}

+ (SYProgressHUD *)showToBottomText:(NSString *)text{
    
    SYProgressHUD *hud = kAllocProgressHUD;
    [kKeyWindows addSubview:hud];
    hud.detailsLabel.font = kHudFont(kHudDetailFontSize);
    hud.detailsLabel.text = text;
    hud.mode = MBProgressHUDModeText;
    hud.margin = 10.0f;
    CGFloat bottomSpaceY = 0.0;
    if (kCURRENT_SCREEN_HEIGHT == 480) {
        bottomSpaceY = 150.0f;
    }else if(kCURRENT_SCREEN_HEIGHT == 568){
        bottomSpaceY = 180.0f;
    }else{
        bottomSpaceY = 200.0f;
    }
    hud.yOffset = bottomSpaceY;
    hud.removeFromSuperViewOnHide = YES;
    hud.animationType = MBProgressHUDAnimationFade;
    [hud hideAnimated:YES afterDelay:delyedTime];
    
    return hud;
}

+ (SYProgressHUD *)showToCustomImage:(UIImage *)image
                                text:(NSString *)text{
    
    SYProgressHUD *hud = kAllocProgressHUD;
    [kKeyWindows addSubview:hud];
    hud.mode = MBProgressHUDModeCustomView;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.label.font = kHudFont(kHudFontSize);
    hud.label.text = text;
    [hud hideAnimated:YES afterDelay:delyedTime];
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(delyedTime);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
    
    
    return hud;
}



@end
