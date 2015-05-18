Tracking #FF00FF colored objects
================================
###To install the openCV port using processing 2.0:  
	Sketch -> import library... -> add library... -> Search for OpenCV for processing

Code is fully commented with explanations on what each  
part does.

###Some calibration needed for values:  
- **rangeLow:** Minimum hue value for color  
- **rangeHigh:** Maximum hue value for color
- **PT\_THRESHOLD:** Number of points counted in a contour  
&nbsp;&nbsp;&nbsp;&nbsp;is affected by how far away/close to the camera the  
&nbsp;&nbsp;&nbsp;&nbsp;tracked object is
  
Done on a macosx 10.8 Mavericks environment on a early 2011 mbp model  
achieving 30 fps
