Slim::Engine.set_default_options pretty: true, format: :html5
Slim::Engine.set_default_options :shortcut => {
  '&' => {:tag => 'input', :attr => 'type'},
  '#' => {:attr => 'id'},
  '.' => {:attr => 'class'}
}

###
# Compass
###

# Change Compass configuration
compass_config do |c|
  c.preferred_syntax = :sass
  c.output_style = :compressed
  c.additional_import_paths = ["/_web/sass"]
  c.line_comments = false
end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

activate :directory_indexes

# Automatic image dimensions on image_tag helper
activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload

# Syntax highlight
# activate :syntax, :line_numbers => true

require "lib/sasuli-helpers"
helpers SasuliHelpers
# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'img'
set :fonts_dir, 'font'
set :helpers_dir, 'helper'

# Build-specific configuration
configure :build do
  # Minify HTML on build
  # activate :minify_html, remove_quotes: false, remove_intertag_spaces: true

  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
