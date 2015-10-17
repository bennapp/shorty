class KeyController < ApplicationController
  def lookup
    key = request.params['path']

    #redirect_to Key.where(:hash => key).first.try(:url)
  end
end
