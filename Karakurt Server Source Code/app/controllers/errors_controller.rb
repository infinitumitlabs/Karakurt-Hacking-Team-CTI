class ErrorsController < ApplicationController

  layout false

  def forbidden; end

  def not_found; end

  def internal_server_error; end
end