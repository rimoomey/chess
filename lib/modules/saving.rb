# frozen_string_literal: true

# IO module for chess game
module Saving
  FILE_NAME = './config/save.yml'
  def save(file_name = FILE_NAME)
    File.new(file_name, 'w') unless File.exist?(file_name)
    file = File.open(file_name, 'w')

    file.puts serialize
  end

  def serialize
    YAML.dump(self)
  end

  def self.load(file_name = FILE_NAME)
    file_contents = File.read(file_name) if File.exist?(file_name)
    deserialize(file_contents)
  end

  def self.deserialize(yaml_string)
    YAML.safe_load(yaml_string, permitted_classes: [Chess, Board, Piece] + Piece.subclasses)
  end
end
