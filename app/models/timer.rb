require 'mongoid'

class Timer
  include Mongoid::Document

  field :name, type: String
  field :running, type: Boolean
  field :started_at, type: Time
  field :elapsed, type: BigDecimal
end
