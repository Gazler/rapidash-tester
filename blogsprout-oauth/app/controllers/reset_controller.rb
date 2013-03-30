class ResetController < ApplicationController
  respond_to :json
  def index
    `rake db:drop db:create db:migrate db:seed`
    respond_with nil
  end
end

