//
//  MLProgressView.h
//  CircularProgress
//
//  Created by Marginlee on 14-3-25.
//  Copyright (c) 2014年 Marginlee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLProgressView : UIView
{
    CGFloat _percent;
}
@property(nonatomic, strong) UIColor *progressTintColor;
@property(nonatomic,strong) NSString *customText;
@property(nonatomic,strong) UILabel *percentLabel;
@property(nonatomic) float progress;
@property(nonatomic) float maxProgress;
-(void)setCustomText:(NSString *)string;
- (void)setProgress:(float)currentProgress;

@end
