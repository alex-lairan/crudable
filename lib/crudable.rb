require_relative 'crudable/paginable'
require_relative 'crudable/sortable'
require_relative 'crudable/toolable'
require_relative 'crudable/crudable'

module Crudable
end

ActiveRecord::Base.class_eval do
  SORTABLE_PARAMS = %i().freeze
end
