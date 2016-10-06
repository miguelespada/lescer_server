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
  field :right_view, type: Float
  field :explored, type: Float
  field :std_dev_x, type: Float
  field :std_dev_y, type: Float


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

<<<<<<< HEAD
  def center_view
    100 - left_view - right_view
  rescue
    0
  end

=======
  def compute_deviation
    xx = []
    yy = []
    data.split("\n").each_with_index do |d, i|
      if i > 0
        tokens = d.split(";")
        xx.push(angleDiff(tokens[2].to_i, ref_x))
        yy.push(angleDiff(tokens[3].to_i, ref_y))
      end
    end
    self.std_dev_x = xx.standard_deviation.round(2)
    self.std_dev_y = yy.standard_deviation.round(2)
    self.save!
  end

  def angleDiff alpha, beta
    a = alpha - beta
    a -= 360 if a > 180
    a += 360 if a < -180
    a.abs
  end



  def deviation_x
    compute_deviation if std_dev_x.nil?
    std_dev_x
  end

  def deviation_y
    compute_deviation if std_dev_y.nil?
    std_dev_y
  end

  def self.compute_deviations
    each do |s|
      s.compute_deviation
    end
  end
>>>>>>> f8293e21629315abfec279b9dcb27d7744256e54
end
