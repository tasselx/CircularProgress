//
//  MLProgressView.m
//  CircularProgress
//
//  Created by Marginlee on 14-3-25.
//  Copyright (c) 2014年 Marginlee. All rights reserved.
//

#import "MLProgressView.h"
#import <QuartzCore/QuartzCore.h>
#define DEGREES_2_RADIANS(x) (0.0174532925 * (x))
#define ToRad(deg) 		( (M_PI * (deg)) / 180.0 )

@implementation MLProgressView
@synthesize customText;
@synthesize percentLabel;
@synthesize progress;
@synthesize maxProgress;
@synthesize progressTintColor;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self setup];
        
        
    }
    return self;
}

-(void)setup
{
    percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    percentLabel.backgroundColor=[UIColor clearColor];
    percentLabel.font=[UIFont systemFontOfSize:60];
    percentLabel.text=[NSString stringWithFormat:@"%f",progress];
    [percentLabel setTextColor:[UIColor whiteColor]];
    [percentLabel setTextAlignment:UITEXTALIGINMENTCENTER];
    [self addSubview:percentLabel];

    UILabel *secondLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-35, self.frame.size.width, 12)];
    secondLabel.backgroundColor=[UIColor clearColor];
    secondLabel.textColor=[UIColor whiteColor];
    secondLabel.text=@"秒";
    secondLabel.font=[UIFont boldSystemFontOfSize:15];
    secondLabel.textAlignment=UITEXTALIGINMENTCENTER;
    [self addSubview:secondLabel];


}


- (void)setCustomText:(NSString *)string{
    percentLabel.text=string;
}


- (void)drawRect:(CGRect)rect
{
    CGSize progressSize=rect.size;
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /**
     *  白色圆
     */
    CGContextSetRGBStrokeColor(context,1,1,1,1.0);
    CGContextSetLineWidth(context, 3.0);
    CGContextAddArc(context, progressSize.width/2, progressSize.height/2, progressSize.height/2-3-10.5, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathStroke);
    
    /**
     *  背景填充圆
     */
    CGContextAddArc(context,progressSize.width/2, progressSize.height/2, progressSize.height/2-3, 0, 2*M_PI, 0);
    CGContextSetFillColorWithColor(context, RGBCLOLOR(246, 248, 249, 0.2).CGColor);
    CGContextDrawPath(context, kCGPathFill);
    
    
    
    CGPoint centerPoint = CGPointMake(rect.size.height / 2, rect.size.width / 2);
    CGFloat radius = MIN(rect.size.height-20, rect.size.width-20) / 2;

    CGFloat pathWidth = radius * 0.1f;
    
    
    CGFloat radians = DEGREES_2_RADIANS((progress/maxProgress*360)-90);
    CGFloat xOffset = radius*(1 + 0.6*cosf(radians));
    CGFloat yOffset = radius*(1 + 0.6*sinf(radians));
    CGPoint endPoint = CGPointMake(xOffset, yOffset);

//    CGFloat yOffset = round(centerPoint.y + (radius-pathWidth/2) * sin(ToRad((_progress/90*360)-90))) ;
//     CGFloat xOffset = round(centerPoint.x + (radius-pathWidth/2) * cos(ToRad((_progress/90*360)-90)));
//    CGPoint endPoint = CGPointMake(xOffset, yOffset);
   
    //进度开始变化时候更改进度颜色
    if (self.progress>0) {
        [self.progressTintColor setFill];
    }
    
    //绕圆心顺时针旋转路径
    CGMutablePathRef progressPath = CGPathCreateMutable();
    CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, radius, DEGREES_2_RADIANS(270), radians, NO);
    
    CGPathCloseSubpath(progressPath);
    CGContextAddPath(context, progressPath);
    CGContextFillPath(context);
    CGPathRelease(progressPath);
    
    //起点圆
    CGContextAddEllipseInRect(context, CGRectMake(centerPoint.x - pathWidth/2, 10, pathWidth, pathWidth));
    CGContextFillPath(context);

    //这边本来是跟随选择的起点的圆的，有点小问题，没让显示。想改的话
    CGContextAddEllipseInRect(context, CGRectMake(endPoint.x - pathWidth/2, endPoint.y - pathWidth/2, pathWidth*2, pathWidth*2));
    CGContextFillPath(context);
    
    CGContextSetBlendMode(context, kCGBlendModeClear);;
    
    CGFloat innerRadius = radius * 0.9f;
	//切出来进度条
    CGPoint newCenterPoint = CGPointMake(centerPoint.x - innerRadius, centerPoint.y - innerRadius);
	CGContextAddEllipseInRect(context, CGRectMake(newCenterPoint.x, newCenterPoint.y, innerRadius*2, innerRadius*2));
   CGContextFillPath(context);


}




- (UIColor *)progressTintColor
{
    if (!progressTintColor)
    {
        progressTintColor = [UIColor colorWithRed:0 green:135/255.0 blue:55/255.0 alpha:1];
    }
    return progressTintColor;
}

- (void)setProgress:(float)currentProgress
{
    progress = currentProgress;
    [self setNeedsDisplay];
}






@end
