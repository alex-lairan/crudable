# rubocop: disable Metrics/AbcSize
# rubocop: disable Metrics/BlockLength
module Crudable
  extend ActiveSupport::Concern
  include Sortable
  include Toolable
  include Paginable
  include Searchable

  included do
    before_action :set_resource, only: %i(destroy show update)

    # GET /api/v2/{plural_resource_name}
    def index
      resources = resource_klass.where(query_params)
                                .order(query_sort)
                                .page(page_params[:page])
                                .per(page_params[:per_page])

      set_plural_resource(resources)
      render json: get_plural_resource
    end

    # GET /api/v2/{plural_resource_name}/1
    def show
      render json: get_resource
    end

    def create
      set_resource(resource_klass.new(resource_params))
      if get_resource.save
        render json: get_resource, status: :created
      else
        render json: get_resource.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/v2/{plural_resource_name}/1
    def update
      if get_resource.update(resource_params)
        render json: get_resource, status: :ok
      else
        render json: get_resource.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/v2/{plural_resource_name}/1
    def destroy
      get_resource.destroy
      head :no_content
    end
  end
end
# rubocop: enable Metrics/BlockLength
# rubocop: enable Metrics/AbcSize
