class ResetController < ApplicationController
  respond_to :json
  def index
    `rake db:drop db:create db:migrate`
    respond_with nil
  end
end
