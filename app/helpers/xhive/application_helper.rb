module Xhive
  module ApplicationHelper
    def initialize_widgets_loader
      "<script type='text/javascript'>WidgetLoader.load()</script>".html_safe
    end

    def include_custom_stylesheets
      # TODO: merge engine routes with Rails application routes
      "<link href='/stylesheets/custom.css' media='all' rel='stylesheet' type='text/css'/>".html_safe
    end

    def render_page_for(resource, action, options={})
      page = current_site.mappers.page_for(resource, action)
      render :inline => page.presenter.render_content(options), :layout => true
    end

    def current_site
      domain = request.host
      @current_site ||= Site.where(:domain => domain).first || Site.first
      fail "No Site defined. Please create a default Site." unless @current_site.present?
      @current_site
    end

    # Private: Returns a safe user, e.i. a logged user or a guest user.
    #
    # This is just a placeholder and should be implemented in the host app.
    #
    # Example:
    #
    # def safe_user
    #   current_user || AnonymousUser.new
    # end
    #
    # Returns: an anonymous user.
    #
    def safe_user
      AnonymousUser.new
    end
  end
end
