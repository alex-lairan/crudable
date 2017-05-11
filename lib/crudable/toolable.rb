# rubocop: disable AccessorMethodName
# rubocop: disable Metrics/BlockLength
module Toolable
  extend ActiveSupport::Concern
  include Sortable

  included do
    private

    # Returns the resource from the created instance variable
    # @return [Object]
    def get_resource
      instance_variable_get("@#{resource_name}")
    end

    # Returns resources from the created instance variable
    # @return Array[Object]
    def get_plural_resource
      instance_variable_get("@#{plural_resource_name}")
    end

    # Returns the allowed parameters for searching
    # Override this method in each API controller
    # to permit additional parameters to search on
    # @return [Hash]
    def query_params
      {}
    end

    def query_sort
      sorted_fields(params[:sort], resource_klass::SORTABLE_PARAMS)
    end

    # Returns the allowed parameters for pagination
    # @return [Hash]
    def page_params
      params.permit(:page, :per_page)
    end

    # The resource class based on the controller
    # @return [Class]
    def resource_klass
      @resource_klass ||= resource_name.classify.constantize
    end

    # The singular name for the resource class based on the controller
    # @return [String]
    def resource_name
      @resource_name ||= controller_name.singularize
    end

    # The plural name for the resource class based on the controller
    # @return [String]
    def plural_resource_name
      @plural_resource_name ||= resource_name.pluralize
    end

    # Only allow a trusted parameter "white list" through.
    # If a single resource is loaded for #create or #update,
    # then the controller for the resource must implement
    # the method "#{resource_name}_params" to limit permitted
    # parameters for the individual model.
    def resource_params
      @resource_params ||= send("#{resource_name}_params")
    end

    def set_resource(resource = nil)
      resource ||= resource_klass.find(params[:id])
      instance_variable_set("@#{resource_name}", resource)
    end

    def set_plural_resource(resources = nil)
      resources ||= resource_klass.all
      instance_variable_set("@#{plural_resource_name}", resources)
    end
  end
end
# rubocop: enable Metrics/BlockLength
# rubocop: enable AccessorMethodName
