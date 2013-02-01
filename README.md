RubyResizeImages:
-----------------

With this small Script it is possible to resize all images from a given folder. 
As default it takes the images from a directory named "images". All the resized
images are going to be store in the directory named "resized". It does show
a progress bar in the terminal itself.

-----------------

With the following command it does resize all images (images folder) by 50% and store them in the "resized" directory

	ruby resize.rb -p 50	
-----------------

[![](	http://www.prine.ch/img/RubyResizeImages.png)](	http://www.prine.ch/img/RubyResizeImages.png)

-----------------


It is using the gem package "mini_magick" to resize the images.