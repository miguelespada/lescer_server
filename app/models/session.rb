class Session
  include Mongoid::Document
  include Mongoid::Timestamps
  field :timestamp, type: String
  field :ref_x, type: Integer
  field :ref_y, type: Integer
  field :ref_z, type: Integer
  field :left_movs, type: Integer
  field :right_movs, type: Integer
  field :reactions, type: String
  field :data, type: String
  field :selected, type: Boolean
  field :x, type: Integer
  field :y, type: Integer
  field :width, type: Integer
  field :height, type: Integer

  belongs_to :patient
  belongs_to :exercice
  accepts_nested_attributes_for :patient
  accepts_nested_attributes_for :exercice
end
