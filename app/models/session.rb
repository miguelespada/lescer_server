class Session
  include Mongoid::Document
  include Mongoid::Timestamps
  field :comments, type: String
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
  field :size, type: Integer
  field :total_time, type: Float
  field :left_view, type: Float
  field :explored, type: Float

  belongs_to :patient
  belongs_to :exercice
  accepts_nested_attributes_for :patient
  accepts_nested_attributes_for :exercice

  def getSize
    if self.size.nil?
      self.size = data.split("\n").count - 1
      self.save!
    end
    self.size
  end

  def getTime
    return total_time.to_i if !total_time.nil?
    (getSize/30).to_i
  end

end
