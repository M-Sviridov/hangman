
require './colorable'

module GameState
  using Colorable
  def save_game
    File.open(random_file_name, 'wb') do |file|
      file.puts YAML.dump(self)
    end
  end

  def random_file_name
    loop do
      filename = "Game_##{rand(1..100)}.yaml"
      filepath = File.join('./saves', filename)

      return filepath unless File.exist?(filepath)
    end
  end

  def load_game(filepath)
    YAML.unsafe_load_file(filepath)
  end

  def files_list
    puts "\n#{'  #  '.bg_color(:frost2)} File Name(s)\n\n"
    files = Dir.entries('./saves').select { |f| File.file?(File.join('./saves', f)) }
    files.each_with_index { |file, index| puts "  #{index + 1}  ".bg_color(:frost2) + " #{file}\n\n" }
    files
  end

  def pick_save
    loop do
      puts 'Enter the save number you wish to load: '
      save_num = gets.chomp.to_i

      return files_list[save_num - 1] if save_num.between?(1, files_list.length)

      puts 'Incorrect save number.'
    end
  end
end