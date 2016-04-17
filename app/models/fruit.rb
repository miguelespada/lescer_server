class Fruit
  include Mongoid::Document
  field :texto, type: String
  field :maximo_tiempo, type: Integer
  field :numero_frutas, type: Integer
  field :items_life, type: Integer
  field :code, type: Integer
end