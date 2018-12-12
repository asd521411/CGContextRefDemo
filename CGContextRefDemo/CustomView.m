//
//  CustomView.m
//  CGContextRefDemo
//
//  Created by hongbaodai on 2018/12/10.
//  Copyright © 2018年 caomaoxiaozi. All rights reserved.
//

#import "CustomView.h"
#define PI 3.14159265358979323846

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self drawCharacter];
}

- (void)drawCharacter {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor cyanColor].CGColor);//设置颜色
    //CGFontRef fontRef = UIGraphi
    //CGContextSetFont(context, <#CGFontRef  _Nullable font#>)
    UIFont *font = [UIFont systemFontOfSize:14];
    //[@"1" drawInRect:CGRectMake(10, 40, 100, 40) withFont:font];//废弃
    [@"画图1" drawInRect:CGRectMake(10, 40, 100, 40) withAttributes:@{NSAttachmentAttributeName:font,NSForegroundColorAttributeName:[UIColor cyanColor]}];
    //画图
    //画圆
    CGContextSetFillColorWithColor(context, [UIColor purpleColor].CGColor);//设置填充的画笔颜色
    //CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    CGContextAddArc(context, 100, 50, 20, 0, 2*PI, 0);//添加一个圆
    CGContextDrawPath(context, kCGPathFill);//填充

    //边框
    CGContextSetRGBStrokeColor(context, 234/255.0, 174/255.0, 59/255.0, 1);//改变设置的画笔颜色
    CGContextSetLineWidth(context, 2);//线宽
    CGContextAddArc(context, 150, 50, 15, 0, 2*PI, 0);
    CGContextDrawPath(context, kCGPathStroke);//划线

    //画圆+填充
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextSetLineWidth(context, 3);
    CGContextSetRGBStrokeColor(context, 234/255.0, 174/255.0, 59/255.0, 1);
    CGContextAddArc(context, 200, 50, 20, 0, 2*PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke);

    //画任意线
    //直线
    CGPoint points[2];
    points[0] = CGPointMake(100, 80);
    points[1] = CGPointMake(120, 90);
    //CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
    //points[]坐标数组，和count大小
    CGContextAddLines(context, points, 2);//添加线
    CGContextDrawPath(context, kCGPathStroke);
    //画弧线
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);//改变画笔颜色
    CGContextMoveToPoint(context, 140, 80);//开始坐标p1
    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
    //从（140，80）p1点到（148，68）（即x1，y1）画一条直线，再到（156，80）（x2，y2）画条直线，和半径radius确定一段圆弧
    CGContextAddArcToPoint(context, 148, 68, 156, 80, 10);
    CGContextStrokePath(context);//绘画路径

    //矩形
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);//线框颜色
    CGContextStrokeRect(context,CGRectMake(100, 120, 20, 20));//画方框
    CGContextSetLineWidth(context, 2.0);//线的宽度

    CGContextSetFillColorWithColor(context, [UIColor cyanColor].CGColor);//填充颜色
    CGContextFillRect(context,CGRectMake(140, 120, 40, 40));//填充框

    //矩形，并填弃渐变颜色
    //第一种填充方式，第一种方式必须导入类库quartcore并#import <QuartzCore/QuartzCore.h>，这个就不属于在context上画，而是将层插入到view层上面。那么这里就设计到Quartz Core 图层编程了。
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    gradient1.frame = CGRectMake(240, 120, 60, 30);
    gradient1.startPoint = CGPointMake(0, 0);
    gradient1.endPoint = CGPointMake(1, 1);//frame左上（0，0）右下（1，1），设置从哪里到哪里渐变
    gradient1.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor,
                        (id)[UIColor grayColor].CGColor,
                        (id)[UIColor blackColor].CGColor,
                        (id)[UIColor yellowColor].CGColor,
                        (id)[UIColor blueColor].CGColor,
                        (id)[UIColor redColor].CGColor,
                        (id)[UIColor greenColor].CGColor,
                        (id)[UIColor orangeColor].CGColor,
                        (id)[UIColor brownColor].CGColor,nil];
    //设置颜色分割点（范围：0-1）
    //self.gradientLayer.locations = @[@(0.0f), @(1.0f)];
    [self.layer insertSublayer:gradient1 atIndex:0];
    //第二种填充方式，<CoreGraphics>
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        1,1,1, 1.00,
        1,1,0, 1.00,
        1,0,0, 1.00,
        1,0,1, 1.00,
        0,1,1, 1.00,
        0,1,0, 1.00,
        0,0,1, 1.00,
        0,0,0, 1.00,
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents
    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));//形成梯形，渐变的效果
    CGColorSpaceRelease(rgb);
    //画线形成一个矩形
    //CGContextSaveGState与CGContextRestoreGState的作用
    /*
     CGContextSaveGState函数的作用是将当前图形状态推入堆栈。之后，您对图形状态所做的修改会影响随后的描画操作，但不影响存储在堆栈中的拷贝。在修改完成后，您可以通过CGContextRestoreGState函数把堆栈顶部的状态弹出，返回到之前的图形状态。这种推入和弹出的方式是回到之前图形状态的快速方法，避免逐个撤消所有的状态修改；这也是将某些状态（比如裁剪路径）恢复到原有设置的唯一方式。
     */
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, 220, 90);
    CGContextAddLineToPoint(context, 240, 90);
    CGContextAddLineToPoint(context, 240, 110);
    CGContextAddLineToPoint(context, 220, 110);
    CGContextClip(context);//context裁剪路径,后续操作的路径
    //CGContextDrawLinearGradient(CGContextRef context,CGGradientRef gradient, CGPoint startPoint, CGPoint endPoint,CGGradientDrawingOptions options)
    //gradient渐变颜色,startPoint开始渐变的起始位置,endPoint结束坐标,options开始坐标之前or开始之后开始渐变
    CGContextDrawLinearGradient(context, gradient,CGPointMake
                                (220,90) ,CGPointMake(240,110),
                                kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);// 恢复到之前的context

    //下面再看一个颜色渐变的圆
    CGContextDrawRadialGradient(context, gradient, CGPointMake(300, 100), 0.0, CGPointMake(300, 100), 10, kCGGradientDrawsBeforeStartLocation);


    /*画扇形和椭圆*/
    //画扇形，也就画圆，只不过是设置角度的大小，形成一个扇形
    CGContextSetFillColorWithColor(context, [UIColor purpleColor].CGColor);//填充颜色
    //以10为半径围绕圆心画指定角度扇形
    CGContextMoveToPoint(context, 160, 180);
    CGContextAddArc(context, 160, 180, 30,  -60 * PI / 180, -120 * PI / 180, 1);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径

    //画椭圆
    CGContextAddEllipseInRect(context, CGRectMake(160, 180, 20, 8)); //椭圆
    CGContextDrawPath(context, kCGPathFillStroke);

    /*画三角形*/
    //只要三个点就行跟画一条线方式一样，把三点连接起来
    CGPoint sPoints[3];//坐标点
    sPoints[0] =CGPointMake(100, 220);//坐标1
    sPoints[1] =CGPointMake(130, 220);//坐标2
    sPoints[2] =CGPointMake(130, 160);//坐标3
    CGContextAddLines(context, sPoints, 3);//添加线
    CGContextClosePath(context);//封起来
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径

    /*画圆角矩形*/
    float fw = 180;
    float fh = 280;

    CGContextMoveToPoint(context, fw, fh-20);  // 开始坐标右边开始
    CGContextAddArcToPoint(context, fw, fh, fw-20, fh, 10);  // 右下角角度
    CGContextAddArcToPoint(context, 120, fh, 120, fh-20, 10); // 左下角角度
    CGContextAddArcToPoint(context, 120, 250, fw-20, 250, 10); // 左上角
    CGContextAddArcToPoint(context, fw, 250, fw, fh-20, 10); // 右上角
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径

    /*画贝塞尔曲线*/
    //二次曲线
    CGContextMoveToPoint(context, 120, 300);//设置Path的起点
    CGContextAddQuadCurveToPoint(context,190, 310, 120, 390);//设置贝塞尔曲线的控制点坐标和终点坐标
    CGContextStrokePath(context);
    //三次曲线函数
    CGContextMoveToPoint(context, 200, 300);//设置Path的起点
    CGContextAddCurveToPoint(context,250, 280, 250, 400, 280, 300);//设置贝塞尔曲线的控制点坐标和控制点坐标终点坐标
    CGContextStrokePath(context);


    /*图片*/
    UIImage *image = [UIImage imageNamed:@"apple.jpg"];
    [image drawInRect:CGRectMake(60, 340, 20, 20)];//在坐标中画出图片
    //    [image drawAtPoint:CGPointMake(100, 340)];//保持图片大小在point点开始画图片，可以把注释去掉看看
    CGContextDrawImage(context, CGRectMake(100, 340, 20, 20), image.CGImage);//使用这个使图片上下颠倒了
     CGContextDrawTiledImage(context, CGRectMake(0, 0, 20, 20), image.CGImage);//平铺图

    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
