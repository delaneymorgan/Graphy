Graphy is a very simple segmented bar chart view for iOS.

It was developed to fill a hole left by (the excellent) core-plot for one of our projects.

Each bar chart consists of the following:

Graph Title
X-Axis +
       +- X-Axis Label
       +- X-Axis major graduation labels
       +- X-Axis minor graduations
Y-Axis +
       +- Y-Axis Label
       +- Y-Axis major graduation labels
       +- Y-Axis minor graduations
Plots +
      +- plot part +
                   +- segment color
                   +- segment amount
Legend +    
       +- segment name
       +- segment color

To use, you'd construct the leaves of the graph view and work up until the graph was completely described.
As a small bonus, none of that construction need happen in the main thread, so it can be off-loaded to NSOperation.

NOTE: This view doesn't support zooming.

NOTE: It does seem to fit in with the resolution independence era as its scrappy pre-retina scaling logic seems to still hold up.

See the Materiel folder for what the result looks like.