# Ruby parser for IATA HOT files

## Introduction

This gem is for parsing HOT files, commonly received from IATA, as described in their BSP DISH standard. These files
contain accounting information that you may want to import into your own system. This library can help you make
sense of its contents. Be aware that it was written for a specific purpose and will probably not cover your
needs, but I'm open to suggestions on how to make it more useful in a generic way.

## Requirements

- Ruby 3 or higher (may work on older versions but not tested)

## Installing this gem

Probably familiar for anyone who used any gem before. Add the gem to your Gemfile:

    gem 'ruby-hotfile'

Install the gem. Run this command in the terminal:

    gem install ruby-hotfile

Alternatively, use bundler for easy gem maintenance:

    gem install bundler
    bundle install

## How to use this gem

Parse a file into a ruby structure, returning the encoded lines is a more readable format:

    Hotfile.new(file).parse

Extract transaction information:

    Hotfile.new(file).transactions
