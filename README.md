#RubyResizeImages:
-----------------

##Description
--

With this small Script it is possible to resize all images from a given folder. 
As default it takes the images from a directory named "images". All the resized
images are going to be store in the directory named "resized". It does show
a progress bar in the terminal itself.

Currently there are two different ways to resize the images:
- By a percent value
- By a given dimension


##Example
-----------------

As example resize all images to 50%:

	ruby resize.rb -p 50	
	
Or if you want to resize by dimensions. It fits either on the width or on the height to the given pixel dimension. (Example: 500x500px):
	
	ruby resize.rb -d 500x500

Input or output directory can be changed with the following argument:

	ruby resize.rb -i new_images_dir -o new_output_dir -p 50
	
-----------------

[![](	http://www.prine.ch/img/RubyResizeImages.png)](	http://www.prine.ch/img/RubyResizeImages.png)


##Installation
-----------------

It is using the gem package "mini_magick" to resize the images. ImageMagick is also needed.

So first install the ImageMagick:
--
###Port - ImageMagick
	sudo port install ImageMagick
	
###Brew - ImageMagick
	brew install ImageMagick
	
###Installer - ImageMagick
http://cactuslab.com/imagemagick/

--
The other required package "mini_magick" can be installed with the following command.

###Gem - mini_magick
	sudo gem install mini_magick


