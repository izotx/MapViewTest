//
//  DJViewController.m
//  MapViewTest
//
//  Created by Janusz Chudzynski on 9/23/13.
//  Copyright (c) 2013 DJMobileInc. All rights reserved.
//

#import "DJViewController.h"
#import "Annotation.h"
#import "AnnotationView.h"


@interface DJViewController ()<MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)addAnnotation:(id)sender;
@property (strong,nonatomic) Annotation * annotation;
@end

@implementation DJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self;
  }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
	}
	
	static NSString * const kPinAnnotationIdentifier = @"PinIdentifier";
	MKAnnotationView *draggablePinView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:kPinAnnotationIdentifier];
    draggablePinView.draggable=YES;
	if (draggablePinView) {
        draggablePinView.annotation = annotation;
    } else {
		draggablePinView = [[AnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:kPinAnnotationIdentifier];
	}
    //	draggablePinView.annotation
	return draggablePinView;

    // return
}


-(void)mapView:(MKMapView *)_mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
    [self.mapView removeOverlays:self.mapView.overlays];

    
    
	if (oldState == MKAnnotationViewDragStateDragging) {
		Annotation *annotation = (Annotation *)annotationView.annotation;
        annotation.title=@"Drag Me";
		annotation.subtitle = [NSString stringWithFormat:@"Latitude %7.4f Longitude %8.4f", (float) annotation.coordinate.latitude, (float) annotation.coordinate.longitude];
        
    }
    if(newState==MKAnnotationViewDragStateEnding)
    {
        Annotation *annotation = (Annotation *)annotationView.annotation;
        //annotation.title=@"Drag Me";
		annotation.subtitle = [NSString stringWithFormat:@"Latitude %7.4f Longitude %8.4f", (float) annotation.coordinate.latitude, (float) annotation.coordinate.longitude];
        
        //Draw the line between two points
    }
    if (newState == MKAnnotationViewDragStateDragging) {
        //NSLog(@"Dragging");
    }
}



- (IBAction)addAnnotation:(id)sender {
    _annotation= [[Annotation alloc]init];
    _annotation.coordinate =self.mapView.centerCoordinate;
    _annotation.title = @"Drag Me";
    [self.mapView addAnnotation:_annotation];

}
@end
