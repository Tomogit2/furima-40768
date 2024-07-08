module ImageHelpers
  def generate_sample_image
    Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample.jpg'))
  end
end