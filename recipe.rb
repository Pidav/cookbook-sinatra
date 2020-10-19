class Recipe
  attr_accessor :name, :description, :rating, :done, :prep_time

  def initialize(arg = {})
    @name = arg[:name]
    @description = arg[:description]
    @rating = arg[:rating]
    @done = arg[:done]
    @prep_time = arg[:prep_time]
  end
end
