//
//  AnnotationView.m
// My World for iPad version 1.2
//

#import "AnnotationView.h"


@implementation AnnotationView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.image = [UIImage imageNamed:@"Pin23"];
        self.draggable=YES;
        self.canShowCallout = YES;
        // self.animatesDrop
    }
    return self;
}

@end
