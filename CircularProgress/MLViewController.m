//
//  MLViewController.m
//  CircularProgress
//
//  Created by Marginlee on 14-3-25.
//  Copyright (c) 2014年 Marginlee. All rights reserved.
//  iOS中国开发者交流群:262091386

#import "MLViewController.h"
#import "MLProgressView.h"
@interface MLViewController ()
{

    MLProgressView *progressView;
    NSTimer *timer;
    int i;
    UIButton *repatBtn;
    int totalTime;//总大小
}
@end

@implementation MLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    i=0;
    totalTime=90;
    self.view.backgroundColor=RGBCLOLOR(42, 201, 144,1);
    progressView=[[MLProgressView alloc] initWithFrame:CGRectMake(80, 100, 150, 150)];
    progressView.backgroundColor=[UIColor clearColor];
    [progressView setCustomText:[NSString stringWithFormat:@"%d",totalTime]];
    [self.view addSubview:progressView];
    
    
     repatBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [repatBtn setFrame:CGRectMake(100, 300, 100, 100)];
    [repatBtn addTarget:self action:@selector(startRepat) forControlEvents:UIControlEventTouchUpInside];
    [repatBtn setTitle:@"开始" forState:UIControlStateNormal];
    [self.view addSubview:repatBtn];
    
    [self startRepat];
    
  
    
}

-(void)startRepat
{
    [timer invalidate];
    [progressView setCustomText:@"90"];

    timer=[NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(changeNum) userInfo:nil repeats:YES];
    [[NSRunLoop  currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer fire];

}
-(void)changeNum
{    i++;
    //设置时间

    progressView.maxProgress=totalTime;
    [progressView setCustomText:[NSString stringWithFormat:@"%d",totalTime-i]];
    if (totalTime-i==0) {
        i=0;
        [timer invalidate];
        
     [repatBtn setTitle:@"重新开始" forState:UIControlStateNormal];
    }
    
    [progressView setCustomText:[NSString stringWithFormat:@"%d",totalTime-i]];
    [progressView setProgress:i];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
