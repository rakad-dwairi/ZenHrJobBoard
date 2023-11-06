class FutureDateValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if value.present? && value <= Time.current
        record.errors.add(attribute, 'must be a future date')
      end
    end
  end
  