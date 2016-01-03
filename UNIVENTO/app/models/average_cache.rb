class AverageCache < ActiveRecord::Base
  belongs_to :rater, :class_name => "Normal"
  belongs_to :rateable, :polymorphic => true
end
