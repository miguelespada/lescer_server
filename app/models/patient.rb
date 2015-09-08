class Patient
  include Mongoid::Document
  field :name, type: String
  has_many :sessions
  field :selected, type: Boolean
  accepts_nested_attributes_for :sessions
end
