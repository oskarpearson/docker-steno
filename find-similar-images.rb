#!/usr/bin/env ruby

require 'docker'
require 'pry'

puts Docker.info
gem_tag_regex = /\Aco\.uk\.deckle\.gemify\.gem\.(\w+)\Z/

image_gems = {}

Docker::Image.all.each do |image|
  labels = image.info["Labels"]

  next unless labels["vendor"] == 'gemify'

  puts "Found a gemify vendor!"

  labels.each do |label, value|
    next unless label =~ gem_tag_regex

    gem_name = label.match(gem_tag_regex).captures.first
    puts "Got a gem_name: #{gem_name}"

    image_gems[gem_name] = value
  end

  pp image_gems
end
