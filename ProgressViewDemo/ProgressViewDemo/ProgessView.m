//
//  ProgessView.m
//  ProgressViewDemo
//
//  Created by 郭庆 on 2021/12/12.
//

#import "ProgessView.h"

#define kLineWidth 6

@interface ProgessView()
{
    CGFloat _layerWidth;
    CGFloat _layerHeight;
}

/// 圆环路径
@property (strong, nonatomic)  UIBezierPath *circlePath;

/// 背景圆环
@property (nonatomic, strong)CAShapeLayer* circleShapeLayer;

/// 渐变图层容器
@property (nonatomic, strong)CALayer *gradientContainerLayer;

/// 进度蒙版图层
@property (nonatomic, strong)CAShapeLayer* progressLayer;

@end

@implementation ProgessView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.fromColor = [UIColor yellowColor];
        self.toColor = [UIColor redColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

    [self.layer addSublayer:self.circleShapeLayer];
    [self.layer addSublayer:self.gradientContainerLayer];
    
    [self setGradientLayer];
}


-(void)setGradientLayer
{
     _layerWidth = self.frame.size.width;
     _layerHeight = self.frame.size.height;
    
    CAGradientLayer *gradientLayer1 = [self gradientLayerWithIndex:0];
    gradientLayer1.position = CGPointMake(3*_layerWidth/4.0, _layerHeight/4.0);
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(1, 1);
    
    CAGradientLayer *gradientLayer2 = [self gradientLayerWithIndex:1];
    gradientLayer2.position = CGPointMake(3*_layerWidth/4.0, _layerHeight/4.0*3);
    gradientLayer2.startPoint = CGPointMake(1, 0);
    gradientLayer2.endPoint = CGPointMake(0, 1);
    
    CAGradientLayer *gradientLayer3 = [self gradientLayerWithIndex:2];
    gradientLayer3.position = CGPointMake(_layerWidth/4.0, _layerHeight/4.0*3);
    gradientLayer3.startPoint = CGPointMake(1, 1);
    gradientLayer3.endPoint = CGPointMake(0, 0);
    
    CAGradientLayer *gradientLayer4 = [self gradientLayerWithIndex:3];
    gradientLayer4.position = CGPointMake(_layerWidth/4.0, _layerHeight/4.0);
    gradientLayer4.startPoint = CGPointMake(0, 1);
    gradientLayer4.endPoint = CGPointMake(1, 0);
    
}

-(CAGradientLayer *)gradientLayerWithIndex:(NSInteger)index
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, _layerWidth/2.0, _layerHeight/2.0);
    [self.gradientContainerLayer addSublayer:gradientLayer];
    gradientLayer.colors = @[(__bridge id)[self colorWithIndex:index].CGColor,
                             (__bridge id)[self colorWithIndex:index+1].CGColor];
    return gradientLayer;
}

-(UIColor *)colorWithIndex:(NSInteger)index
{
    CGFloat fromRed,fromGreen,fromBlue,fromAlpha,toRed,toGreen,toBlue,toAlpha;
    [self.fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    [self.toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    return [UIColor colorWithRed:gradientColor(fromRed, toRed, (int)index) green:gradientColor(fromGreen, toGreen, (int)index) blue:gradientColor(fromBlue, toBlue, (int)index) alpha:gradientColor(fromAlpha, toAlpha, (int)index)];
}
static float __attribute__((always_inline)) gradientColor(float fromColor, float toColor, int index)
{
    float color = (toColor - fromColor)/4.0 * index + fromColor;
    return color;
}

#pragma mark - -------------------Public-----------------------
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    self.progressLayer.strokeEnd = progress;
}


#pragma mark - -------------------Getters----------------------

- (UIBezierPath *)circlePath
{
    if (!_circlePath) {
        _circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:(self.bounds.size.width - kLineWidth) /2 startAngle:-M_PI / 2 endAngle:-M_PI /2+2*M_PI clockwise:YES];
    }
    return _circlePath;
}
- (CAShapeLayer *)progressLayer
{
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = self.bounds;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.lineWidth = 6;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.strokeColor = [UIColor blueColor].CGColor;
        _progressLayer.strokeStart = 0.01;
        _progressLayer.strokeEnd = 0.0;
        _progressLayer.path = self.circlePath.CGPath;
    }
    return _progressLayer;
}

- (CAShapeLayer *)circleShapeLayer
{
    if (!_circleShapeLayer) {
        CAShapeLayer *bgLayer = [CAShapeLayer layer];
        bgLayer.frame = self.bounds;
        bgLayer.fillColor = [UIColor clearColor].CGColor;//填充色 -  透明色
        bgLayer.lineWidth = 3;
        bgLayer.strokeColor = [UIColor colorWithRed:255/255.0 green:216/255.0 blue:197/255.0 alpha:1].CGColor;//线条颜色
        bgLayer.strokeStart = 0;
        bgLayer.strokeEnd = 1;
        bgLayer.lineCap = kCALineCapRound;
        bgLayer.path = self.circlePath.CGPath;
        _circleShapeLayer = bgLayer;
    }
    
    return _circleShapeLayer;
}

- (CALayer *)gradientContainerLayer
{
    if (!_gradientContainerLayer) {
        _gradientContainerLayer = [CALayer layer];
        _gradientContainerLayer.frame = self.bounds;
        _gradientContainerLayer.mask = self.progressLayer;
    }
    return _gradientContainerLayer;
}


@end
