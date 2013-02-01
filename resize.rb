#!/usr/bin/env ruby
require 'optparse'
require 'ostruct'
require './ResizeTool.rb'

Version = "1.0"

options = OpenStruct.new
opts = OptionParser.new do |o|
  o.separator("Provides functionality to resize images in different way.")
  o.separator("")
  o.separator("Standard values:")
  o.separator("Inputfolder: 'images'")
  o.separator("Outputfolder: 'resized'")
  o.separator("")

  o.on("-p", "--percent [PERCENT]", "Resize an image per percent") do |percent|
    options.percent = percent
  end
  
  o.on("-d", "--dimensions [DIMENSIONS]", "Resize to a defined dimension (Example: 600x600)") do |dimensions|
    options.dimensions = dimensions
  end
  
  o.on("-i", "--input-folder [INPUT_FOLDER]", "Inputfolder, where to get the pictures from") do |input_folder|
    options.input_folder = input_folder
  end
  
  o.on("-o", "--output-folder [OUTPUT_FOLDER]", "Outputfolder, where to save the newly generated pictures") do |output_folder|
    options.output_folder = output_folder
  end
  
  o.on_tail("--version", "Show version") do
    puts o.ver
    puts "Written by Robin Oster"
    puts ""
    puts "Copyright (C) 2013 prine development - prine.ch"
    exit
  end
  
  o.on("-h", "--help", "This help")do
    puts o
    exit
  end
end


begin
  opts.parse!(ARGV)
  resize_tool = ResizeTool.new

  if(options.percent != nil)
    # check percent value
    while (options.percent == "")
      puts "Enter percent value: "
      options.percent = gets.chomp    
    end
  end
    
  # dimensions should not be empty
  if(options.dimensions != nil)
    while(options.dimensions == "")
      puts "Please enter correct dimensions (Example: 600x600): "
      options.dimensions = gets.chomp
    end
  end
  
  if(options.input_folder != nil)
    while(options.input_folder == "")
      puts "Input_folder cannot be empty. Please insert new one:"
    end
    
    resize_tool.set_input_folder(options.input_folder)
  end
  
  if(options.output_folder != nil)
    while(options.output_folder == "")
      puts "Output_folder cannot be empty. Please insert new one:"
    end
    
    resize_tool.set_output_folder(options.output_folder)
  end
  
  
  # resize per percent
  if(options.percent != "" && options.percent != nil)
    resize_tool.resize_percent(options.percent)
  end  
   
  # resize per width and height
  if(options.dimensions != nil)
    resize_tool.resize_with_dimensions(options.dimensions)
  end
end
