# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rails_no_database_in_view/version"

Gem::Specification.new do |s|
  s.name        = "rails_no_database_in_view"
  s.version     = RailsNoDatabaseInView::VERSION
  s.authors     = ["Joel Plane"]
  s.email       = ["joel.plane@gmail.com"]
  s.homepage    = "https://github.com/joelplane/rails_no_database_in_view"
  s.summary     = %q{Prevent database access from the view}
  s.description = %q{Force loading all data from the controller by raising when the database is accessed from the view. This can help create effective database queries and help avoid SQL N+1 problems.}

  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_runtime_dependency "rails", '>= 3.1.1'
end
