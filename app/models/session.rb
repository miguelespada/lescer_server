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

  field :rows, type: Array


  def report
    
    table = []
    11.times do |x| 
      table << []
      11.times do 
        table[x] << 0
      end
    end
    rows.each do |r|
      hist_x = map(r[0].to_f, 0, 400, 0, 11)
      hist_y = map(r[1].to_f, 400, 0, 0, 11)
      table[hist_y][hist_x] += 1
    end
    table
  end

  def map value, inputMin, inputMax, outputMin, outputMax
    ((value - inputMin) / (inputMax - inputMin) * (outputMax - outputMin) + outputMin)
  end

end
