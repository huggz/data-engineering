class Upload
  include ActiveModel::Model

  attr_accessor :file
  attr_reader :revenue

  validates :file, presence: true

  def initialize(attributes = {})
    assign_attributes(attributes)
  end

  def assign_attributes(attributes = {})
    attributes.each do |attr, value|
      self.public_send("#{attr}=", value)
    end if attributes
  end

  def save
    return false unless valid?

    @revenue = Importer.new(file.tempfile.path).process
    true
  rescue => e
    logger.error(e.message)
    errors.add(:file, :invalid)
    false
  end

  private

  def logger
    Rails.logger
  end
end
