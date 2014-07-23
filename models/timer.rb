require 'mongoid'

class Timer
  include Mongoid::Document

  field :name, type: String
  field :running, type: Boolean
  field :elapsed_time, type: Time
end