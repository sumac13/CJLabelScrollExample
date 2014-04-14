//
//  ViewController.m
//  CJLabelScrollExample
//
//  Created by Camus Ulloa-Jonsson on 14/04/2014.
//  Copyright (c) 2014 SumacApps. All rights reserved.
//

#import "ViewController.h"
#import "CJLabelScroll.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1.0];
    
    CJLabelScroll *labelScrollExample = [[CJLabelScroll alloc] initWithFrame:CGRectMake(85, 100, 150, 40)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:16];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"This is a demo of a scrollable text view that you can use and move around";
    [label sizeToFit];
    
    labelScrollExample.label = label;
    
    [self.view addSubview:labelScrollExample];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
