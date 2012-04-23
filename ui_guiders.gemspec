# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ui_guiders"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Roman Snitko"]
  s.date = "2012-04-23"
  s.description = "It's like \"Guiders-JS\", but easily customizable and less js-centric."
  s.email = "roman.snitko@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.markdown"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.markdown",
    "Rakefile",
    "Screenshot.png",
    "VERSION",
    "app/assets/images/ui_guiders/bottom_arrow.png",
    "app/assets/images/ui_guiders/box_bgrnd.png",
    "app/assets/images/ui_guiders/close_ico.png",
    "app/assets/images/ui_guiders/left_arrow.png",
    "app/assets/images/ui_guiders/right_arrow.png",
    "app/assets/images/ui_guiders/top_arrow.png",
    "app/assets/javascripts/lib/ui_guiders.js.coffee",
    "app/assets/stylesheets/ui_guiders.css.scss",
    "app/helpers/ui_guiders_helper.rb",
    "app/views/shared/_ui_guider.haml",
    "lib/ui_guiders.rb"
  ]
  s.homepage = "http://github.com/snitko/ui_guiders"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.21"
  s.summary = "Visual guiders for website UIs."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.1.3"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.3"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.1.3"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.1.3"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
  end
end

