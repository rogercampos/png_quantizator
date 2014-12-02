require "png_quantizator/version"
require 'open3'
require 'fileutils'
require 'securerandom'
require 'tempfile'

module PngQuantizator
  class PngQuantError < StandardError; end

  class Image
    def initialize(file_path)
      raise ArgumentError, "could not find #{file_path}" unless File.file?(file_path)

      @file_path = file_path
    end

    def quantize!(colors = 256)
      Tempfile.open([SecureRandom.hex(16), ".png"]) do |temp_path|
        res = quantize_to(temp_path, colors)
        FileUtils.cp(temp_path, @file_path)

        temp_path.close
        temp_path.delete
        res
      end
    end

    def quantize_to(destination_path, colors = 256)
      raise PngQuantError, "pngquant not found in PATH=#{ENV['PATH']}" unless which("pngquant")

      exit_code, err_msg = Open3.popen3("pngquant #{colors}") do |stdin, stdout, stderr, wait_thr|
        stdin.write(File.read(@file_path))
        stdin.close

        File.open(destination_path, "w") do |f|
          f.write stdout.gets(nil)
          f.flush
        end

        [wait_thr.value, stderr.gets(nil)]
      end

      raise(PngQuantError, err_msg) if exit_code != 0
      true
    end

    private

    def which(cmd)
      exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
      ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
        exts.each { |ext|
          exe = File.join(path, "#{cmd}#{ext}")
          return exe if File.executable? exe
        }
      end

      nil
    end
  end
end
