class ErrorMessageSerializer < ActiveModel::Serializer
  
  def self.error_messages(errors)
    errors.map do |error|
      "#{error.attribute} #{error.message}"
    end
  end
  
end
