module Sortable
  extend ActiveSupport::Concern

  included do
    def sorted_fields(sort, allowed, default = nil)
      allowed = allowed.map(&:to_s)
      fields = sort.to_s.split(',')

      ordered_fields = convert_to_ordered_hash(fields)
      fields = ordered_fields.select { |key, _v| allowed.include?(key) }

      fields.present? ? fields : default
    end

    def convert_to_ordered_hash(fields)
      fields.each_with_object({}) do |field, hash|
        if field.start_with?('-')
          field = field[1..-1]
          hash[field] = :desc
        else
          hash[field] = :asc
        end
      end
    end
  end
end
