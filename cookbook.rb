require 'csv'
require_relative "recipe"

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    @recipes = loading_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    writing_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    writing_csv
  end

  def mark_as_done(recipe_index)
    @recipes[recipe_index].done = true
    writing_csv
    @recipes[recipe_index].name
  end

  def loading_csv
    # no headers  headers: :first_row
    # csv_options = { col_sep: ',', quote_char: '"' }
    CSV.foreach(@csv_file_path) do |row|
      # recipe_done = row[3] == "true" ? true : false
      @recipes << Recipe.new(
        { name: row[0],
          description: row[1],
          rating: row[2],
          done: (row[3] == "true"),
          prep_time: row[4] }
      )
    end
    @recipes
  end

  def writing_csv
    # no headers  headers: :first_row
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      @recipes.each do |v|
        csv << [v.name, v.description, v.rating, v.done, v.prep_time]
      end
    end
  end
end
