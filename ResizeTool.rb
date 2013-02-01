require 'rubygems'
require 'mini_magick'

#
# ResizeTool - v2
#
# @author: Robin Oster
# @email: hugowalker@gmail.com
#
class ResizeTool
  
  # Add accepted extensions here
  ACCEPTED_EXTENSIONS = [".jpg", ".gif", ".png"]
  
  #
  # Initialize input folder and output folder
  #
  def initialize(input_folder = "images", output_folder = "resized")
    @input_folder = input_folder
    @output_folder = output_folder
    
    @amount_images_drawn = 0
    @amount_images_total = 0
  end
  
  #
  # Check if the folders does exists if not create them. 
  # Additionally counts the amount of files.
  #
  def precheck
    
    # check if the inputfolder does exists
    unless File.exists?(@input_folder)
      Dir.mkdir(@input_folder)
    end
    
    # check if the outputfolder does exists
    unless File.exists?(@output_folder)
      Dir.mkdir(@output_folder)
    end
    
    # Count files
    Dir.new(@input_folder).entries.each do |file|
      if ACCEPTED_EXTENSIONS.include?(File.extname(file).downcase)
        @amount_images_total += 1
      end
      GC.start
    end
  end
  
  # 
  # Read directory (Only executes proc when it is an accepted image format)
  # 
  def read_directory(directory, proc)
     
    Dir.new(@input_folder).entries.each do |file|
      if ACCEPTED_EXTENSIONS.include?(File.extname(file).downcase)
        proc.call(file)
        draw_progress()
      end
      GC.start
    end
  end
  
  def draw_progress()
    @amount_images_drawn += 1
    
    system("clear")
    
    print "___ResizeTool is converting: \r\n"
    print "============================ \r\n"
    
    current_percentage = (@amount_images_drawn.to_f/@amount_images_total.to_f)*100.0
    
    print "|"
    
    for i in 0..50 do
      if (i < current_percentage/2)
        print "|"
      else
        print " "
      end
    end
    
    print "|  "
    print current_percentage.round
    print " % \t"
    print @amount_images_drawn
    print "/"
    print @amount_images_total
    print " \r\n"
  end
  
  #
  # Resize with percent
  #
  def resize_percent(percent) 
    
    precheck()
    
    resize_percent = Proc.new do |file|
      
      input_filepath = @input_folder + "/" + file
      output_filepath = @output_folder + "/resized_" + file
      
      image = MiniMagick::Image.open(input_filepath)
      image.scale "#{percent.to_f}%"
      image.write(output_filepath)
      
      GC.start
    end  
    
    read_directory(@input_folder, resize_percent)
  end
  
  #
  # Resize with given dimensions
  #
  def resize_with_dimensions(dimensions)
    
    precheck()
    
    resize_with_dimensions = Proc.new do |file|
      
      input_filepath = @input_folder + "/" + file
      output_filepath = @output_folder + "/resized_" + file
      
      image = MiniMagick::Image.open(input_filepath)
      image.resize "#{dimensions}"
      image.write(output_filepath)
    end
    
    read_directory(@input_folder, resize_with_dimensions)
  end

  #
  # Set the input folder
  #
  def set_input_folder(input_folder)
    @input_folder = input_folder
  end
  
  #
  # Set the output folder
  #
  def set_output_folder(output_folder)    
    @output_folder = output_folder
  end
end
