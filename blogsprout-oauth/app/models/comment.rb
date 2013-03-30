class Comment < ActiveRecord::Base
  attr_accessible :author, :comment, :post_id
end
