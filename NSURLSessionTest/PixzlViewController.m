//
//  ViewController.m
//  NSURLSessionTest
//
//  Created by Pixzl on 01.10.16.
//  Copyright © 2016 Pixzl. All rights reserved.
//
//  Website: http://www.pixzl.de
//  Twitter: http://www.twitter.com/PixzlDE
//  Facebook: http://www.facebook.com/PIXZL
//

#import "PixzlViewController.h"

@interface PixzlViewController ()

@property (strong, nonatomic) IBOutlet UIImage *previewImage;
@property (strong, nonatomic) IBOutlet UIImageView *showImage;
@property (strong, nonatomic) IBOutlet UIButton *downloadButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *clearButton;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (strong, nonatomic) IBOutlet UILabel *urlLabel;

@end

@implementation PixzlViewController


#pragma mark
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"PixzlNSURLSession"; // NavigationBar Title
    self.clearButton.enabled = NO; // clearButton deactivated
    self.urlLabel.hidden = YES; // set urlLabel hidden
}





#pragma mark
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}





#pragma mark
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:self.previewImage];
    [img self];
    
    self.showImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.showImage setImage:self.previewImage];
    [self.backgroundImage setImage:self.previewImage];
    
    NSURL *url = [NSURL URLWithString:@"https://pbs.twimg.com/profile_images/726096723102277634/DSX8hG3p.jpg"];
    NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
    {
       self.previewImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
    }];
    
    self.urlLabel.text = [NSString stringWithFormat:@"%@", url];
    self.urlLabel.hidden = YES;
    
    NSLog(@"Download URL: %@", url);
    
    [downloadPhotoTask resume];
}





#pragma mark
- (IBAction)downloadTask:(id)sender
{
    [self viewWillAppear:YES];
    self.view.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1]; // black BackgroundView
    
    self.urlLabel.hidden = NO; // set urlLabel no more hidden
    self.downloadButton.enabled = NO; // downloadButton deactivated
    self.downloadButton.hidden = YES; // downloadButton hidden
    self.clearButton.enabled = YES; // clearButton activated
}





#pragma mark
- (IBAction)clearButton:(id)sender
{
    self.showImage.image = [UIImage imageNamed:@""]; // delete Image
    self.backgroundImage.image = [UIImage imageNamed:@""]; // delete backgroundImage
    
    self.view.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]; // white BackgroundView
    
    self.urlLabel.hidden = YES; // set urlLabel hidden
    self.clearButton.enabled = NO; // clearButton deactivated
    self.downloadButton.enabled = YES; // downlaodButton activated
    self.downloadButton.hidden = NO; // downloadButton not hidden
}



@end
