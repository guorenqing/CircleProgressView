//
//  ViewController.m
//  ProgressViewDemo
//
//  Created by 郭庆 on 2021/12/12.
//

#import "ViewController.h"
#import "ProgessView.h"

@interface ViewController ()
@property (nonatomic,strong) ProgessView *loadingView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.loadingView = [[ProgessView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:self.loadingView];
    self.loadingView.center = self.view.center;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.loadingView.progress = arc4random()%300/300.0;
}


@end
