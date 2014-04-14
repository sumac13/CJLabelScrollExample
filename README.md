CJLabelScrollExample
====================

Simple UILabel Scroll View

Simplified and stripped down version of Marquee Label that allows you to add a UILabel or custom label subclass
such that the user can interact with longer text than could fit on the screen or view.

Use:

Simply Create a CJLabelScroll

CJLabelScroll *labelScrollExample = [[CJLabelScroll alloc] initWithFrame:CGRectMake(85, 100, 150, 40)];

//create and size a UILabel

UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];

label.textColor = [UIColor blackColor];

label.font = [UIFont systemFontOfSize:16];

label.backgroundColor = [UIColor clearColor];

label.text = @"This is a demo of a scrollable text view that you can use and move around";

[label sizeToFit];

//set the label property CJLabelScroll

labelScrollExample.label = label;
    
//add CJLabelScroll to the parent view    

[self.view addSubview:labelScrollExample];

Customisation:

@property (nonatomic, assign) CGFloat fadeLength;

the length of the fading shadow present to indicate more text is available by scrolling

@property (nonatomic, assign) CGFloat animationDuration;

the duration of the animation to remove the shadow when the scroll view reaches the far left or right
