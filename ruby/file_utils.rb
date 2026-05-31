# frozen_string_literal: true

# File utility functions — reading, writing, searching, and analysis.
module FileUtils
  module_function

  # Read a file and return its contents as a string.
  def read(path)
    File.read(path)
  rescue Errno::ENOENT
    raise "File not found: #{path}"
  end

  # Write content to a file, creating parent directories if needed.
  def write(path, content)
    dir = File.dirname(path)
    FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
    File.write(path, content)
  end

  # Recursively find all files matching a glob pattern.
  def find(root, pattern = '**/*')
    Dir.glob(File.join(root, pattern)).select { |f| File.file?(f) }
  end

  # Count lines of code in a directory, excluding common noise.
  def loc(root, extensions: %w[.rb .py .js .ts .rs .go .java])
    total = 0
    extensions.each do |ext|
      Dir.glob(File.join(root, "**/*#{ext}")).each do |f|
        next if f.include?('node_modules') || f.include?('.git')
        total += File.readlines(f).count { |line| line.strip.length.positive? }
      end
    end
    total
  end

  # List the 10 largest files in a directory tree.
  def largest_files(root, limit: 10)
    files = Dir.glob(File.join(root, '**/*')).select { |f| File.file?(f) }
    files.map { |f| [f, File.size(f)] }
         .sort_by { |_, size| -size }
         .first(limit)
  end
end
