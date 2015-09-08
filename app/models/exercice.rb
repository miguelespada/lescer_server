class Exercice
  include Mongoid::Document
  field :name, type: String
  field :width, type: Integer
  field :height, type: Integer
  has_many :sessions
  field :selected, type: Boolean
  accepts_nested_attributes_for :sessions

  def self.selected
    where(selected: :true).first
  end
end
