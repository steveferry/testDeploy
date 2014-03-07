class Comment < ActiveRecord::Base
  belongs_to :post
  self.per_page = 2
end
