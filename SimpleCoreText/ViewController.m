//
//  ViewController.m
//  SimpleCoreText
//
//  Created by Michael Luton on 5/10/12.
//  Copyright (c) 2012 Michael Luton. All rights reserved.
//

#import "ViewController.h"
#import "CoreTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Create an instance of CoreTextView and add it to the view. The
    // CoreTextView object is responsible for drawing itself. All of the
    // interesting code is in the CoreTextView files.
    CoreTextView *coreTextView = [[CoreTextView alloc] initWithFrame:CGRectMake(20, 50, 280, 32)];
    [self.view addSubview:coreTextView];
}

@end
