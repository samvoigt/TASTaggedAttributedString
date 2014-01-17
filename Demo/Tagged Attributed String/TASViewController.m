//
//  TASViewController.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 10/16/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import "TASViewController.h"
#import "NSString+TaggedAttributedString.h"

@interface TASViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet UITextView *outputTextView;

@end

@implementation TASViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.inputTextView.text = nil;
    self.outputTextView.text = nil;
}

- (IBAction)attributeButtonPressed:(id)sender {
    self.outputTextView.attributedText = [self.inputTextView.text attributedStringFromTaggedString];
    [self.inputTextView resignFirstResponder];
}


@end
