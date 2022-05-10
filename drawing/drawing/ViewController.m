//
//  ViewController.m
//  drawing
//
//  Created by Abobus on 5/11/22.
//  Copyright © 2022 Abobus. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *canvas;

@property CGPoint lastPoint;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    [self setLastPoint:[touch locationInView:self.view]];}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGRect drawRect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [[[self canvas] image] drawInRect:drawRect]; CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound); CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0f); CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0f, 0.0f, 0.0f, 1.0f); CGContextBeginPath(UIGraphicsGetCurrentContext()); CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x,
    _lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    [[self canvas] setImage:UIGraphicsGetImageFromCurrentImageContext()]; UIGraphicsEndImageContext();
    _lastPoint = currentPoint;}

@end
