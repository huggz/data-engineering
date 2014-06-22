module FixtureHelper
  def fixture_file(path, mime_type = nil, binary = false)
    extend ActionDispatch::TestProcess

    fixture_file_upload(path, mime_type, binary).tap do |upload_file|
      class << upload_file
        attr_reader :tempfile
      end
    end
  end
end
