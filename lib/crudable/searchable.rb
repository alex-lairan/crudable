module Searchable
  extend ActiveSupport::Concern
  include Toolable
  include Sortable

  included do
    def search
      set_plural_resource(resource_searched(filtering_params.first))
      filtering_params.map do |column|
        set_plural_resource(get_plural_resource.or(resource_searched(column)))
      end

      set_plural_resource(get_plural_resource.order(query_sort))
      set_plural_resource(get_plural_resource.page(page_params[:page])
                                             .per(page_params[:per_page]))

      render json: get_plural_resource.to_json
    end

    private

    def filtering_params
      []
    end

    def resource_searched(column)
      resource_klass.where(match(column))
    end

    def table
      resource_klass.arel_table
    end

    def search_value
      params['value']
    end

    def match(column)
      table[column].matches("%#{search_value}%")
    end

    def pagination_resource
      get_plural_resource
    end
  end
end
