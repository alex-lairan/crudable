module Paginable
  extend ActiveSupport::Concern

  included do
    after_action :pagination_headers, only: %i(index)

    def pagination_headers
      element = pagination_resource
      headers['X-Total-Count'] = element.total_count
      headers['X-Total-Pages'] = element.total_pages
      headers['X-Current-Page'] = element.current_page
    end

    private

    def pagination_resource
      raise 'Set a pagination_resource method !'
    end
  end
end
