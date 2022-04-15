class ApplicationController < ActionController::Base

#  http_basic_authenticate_with name: 'PKFrpbMRvpGnq9Y6zjgKC8Ndj97td8BfYGV7VdM2fYRQnJPvne',
#                               password: 'cVQ566xD8Rq7uyZEMrExKXdv5tfT5X3EtVUKRDLqxUgDKVy5Z2'

  # protect_from_forgery prepend: true
  #
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
