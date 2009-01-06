require 'rubygems'
require 'uv'

# takes about a second to this, if we don't do it now, then the first call to highlight will take a little longer
Uv.init_syntaxes 

ActionView::Base.send(:include, TmSyntaxHighlighting::Helper)
ActionController::Base.send(:extend, TmSyntaxHighlighting::Controller)

