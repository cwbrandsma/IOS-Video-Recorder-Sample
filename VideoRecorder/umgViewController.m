//
//  umgViewController.m
//  VideoRecorder
//
//  Created by Chris Brandsma on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "umgViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation umgViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


- (void) recordVideo {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    picker.videoQuality = UIImagePickerControllerQualityType640x480;

    
    NSArray *sourceTypes = 
    [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    if (![sourceTypes containsObject:(NSString *)kUTTypeMovie ]){
        NSLog(@"Can't save videos");
    }

    
    
    [self presentModalViewController:picker animated:YES];
    [picker release];   
}


- (IBAction)startRecordClick:(id)sender {
    [self recordVideo];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if (![mediaType isEqualToString:kUTTypeMovie])
        return;
    
    NSURL *mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
    NSString* moviePath = mediaURL.absoluteString;
    NSString *tempFilePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
    NSLog(tempFilePath);
    
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(tempFilePath))
    {
        UISaveVideoAtPathToSavedPhotosAlbum (tempFilePath, nil, nil, nil);   
    }
    
    [picker  dismissModalViewControllerAnimated: YES];
    [picker release];

}

-(void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"Finished with error: %@", error);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker  dismissModalViewControllerAnimated: YES];
    [picker release];

}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{ 
}
    - (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
        
    }


@end
