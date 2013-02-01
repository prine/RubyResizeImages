#!/usr/bin/env ruby
require 'optparse'
require 'ostruct'
require './ResizeTool.rb'

Version = "0.1"

options = OpenStruct.new
opts = OptionParser.new do |o|
  o.separator("Provides functionality to resize images in different way.")
  o.separator("")
  o.separator("Standard values:")
  o.separator("Inputfolder: '.' (current directory)")
  o.separator("Outputfolder: 'resized'")
  o.separator("")

  o.on("-p", "--percent [PERCENT]", "Resize an image per percent") do |percent|
    options.percent = percent
  end
  o.on("-x", "--width [WIDTH]", "Resize image per pixel - Width") do |width|
    options.width = width
  end
  o.on("-y", "--height [HEIGHT]", "Resize image per pixel - Height") do |height|
    options.height = height
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
    puts "Copyright (C) 2013 University of Applied Sciences Northwestern Switzerland"
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

  # check percent value
  while (options.percent == "")
    puts "Enter percent value: "
    options.percent = gets.chomp    
  end
    
  # check width value and check if the relational height is correctly setted
  if(options.width != nil)
    while(options.width == "")
      puts "Please enter a width value: "
      options.width = gets.chomp
    end
    
    while(options.height == "" || options.height == nil)
      puts "Please enter a height value: " 
      options.height = gets.chomp
    end
  end
  
  # check height value and check if the relational width is correctly setted
  if(options.height != nil)
    while(options.height == "")
      puts "Please enter a height value: "
      options.height = gets.chomp
    end
    
    while(options.width == "" || options.width == nil)
      puts "Please enter a width value: " 
      options.width = gets.chomp
    end
  end
  
  # resize per percent
  if(options.percent != "" && options.percent != nil)
    resize_tool.resize_percent(options.percent, options.texton)
  end  
   
  # resize per width and height
  if(options.height != nil && options.width != nil)
    resize_tool.resize_width_height(options.width, options.texton)
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
    
    resize_tool.set_out_folder(options.output_folder)
  end
end
