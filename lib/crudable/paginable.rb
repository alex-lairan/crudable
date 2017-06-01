module Paginable
  extend ActiveSupport::Concern
  include Toolable

  included do
    after_action :pagination_headers, only: %i(index)

    def pagination_headers
      element = pagination_resource
      headers['X-Total-Count'] = element.total_count
      headers['X-Total-Pages'] = element.total_pages
      headers['X-Current-Page'] = element.current_page
      headers['X-Count-Per-Page'] = element.limit_value
    end

    private

    def pagination_resource
      instance_variable_get(plural_resource_name)
    end
  end
end
