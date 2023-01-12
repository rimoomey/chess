# frozen_string_literal: true

# IO module for chess game
module Saving
  FILE_NAME = './config/save.yml'
  def save
    File.new(FILE_NAME, 'w') unless File.exist?(FILE_NAME)
    file = File.open(FILE_NAME, 'w')

    file.puts serialize
  end

  def serialize
    YAML.dump(self)
  end

  def self.load
    file_contents = File.read(FILE_NAME) if File.exist?(FILE_NAME)
    deserialize(file_contents)
  end

  def self.deserialize(yaml_string)
    YAML.safe_load(yaml_string, permitted_classes: [Chess, Board, Piece] + Piece.subclasses)
  end
end
