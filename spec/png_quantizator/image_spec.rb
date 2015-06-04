require 'png_quantizator'

describe PngQuantizator::Image do
  let(:test_jpg) { File.join(File.dirname(__FILE__), "../data/sample.jpg") }
  let(:test_png) { File.join(File.dirname(__FILE__), "../data/sample.png") }

  around do |block|
    Dir.mktmpdir do |dir|
      @tmpdir = dir
      block.run
    end
  end

  describe "#quantize_to" do
    it "should not work with jpg files" do
      quantized = PngQuantizator::Image.new(test_jpg)
      expect { quantized.quantize_to("#{@tmpdir}/cucota.png") }.to raise_error(PngQuantizator::PngQuantError)
    end

    it "should work with png files" do
      quantized = PngQuantizator::Image.new(test_png)
      quantized.quantize_to("#{@tmpdir}/cucota.png").should be_true

      File.file?("#{@tmpdir}/cucota.png").should be_true
      File.size("#{@tmpdir}/cucota.png").should < File.size(test_png)

      FileUtils.rm_rf("#{@tmpdir}/cucota.png")
    end
  end

  describe "#quantize!" do
    let(:original_file_path) { "#{@tmpdir}/abracadabra.png" }

    before do
      FileUtils.cp(test_png, original_file_path)
    end

    after do
      FileUtils.rm_rf(original_file_path)
    end

    it "should pngquantize in place" do
      foo = File.size(original_file_path)
      PngQuantizator::Image.new(original_file_path).quantize!

      File.file?(original_file_path).should be_true
      File.size(original_file_path).should < foo
    end

    it "should not leave residual files in tmp" do
      foo = `ls -1 #{@tmpdir}/*.png | wc -l`
      PngQuantizator::Image.new(original_file_path).quantize!
      foo.should == `ls -1 #{@tmpdir}/*.png | wc -l`
    end
  end
end

