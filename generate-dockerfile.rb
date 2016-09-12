#!/usr/bin/env ruby

specs = {}

lockfile = Bundler::LockfileParser.new(Bundler.read_file("Gemfile.lock"))

puts <<EOHEADER
FROM ruby:2.3.1

EOHEADER

install_lines = lockfile.specs.map { |spec| "gem install #{spec.name} --version='#{spec.version}'" }

puts "RUN " + install_lines.join(" && \\\n    ")

puts "\n"

spec_lines = lockfile.specs.map { |spec| "co.uk.deckle.gemify.gem.#{spec.name}='#{spec.version}'" }
puts "LABEL vendor=gemify \\\n    " + spec_lines.join(" \\\n    ")
