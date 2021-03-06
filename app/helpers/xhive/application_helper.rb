module Xhive
  module ApplicationHelper
    def initialize_widgets_loader
      "<script type='text/javascript'>WidgetLoader.load()</script>".html_safe
    end

    def include_custom_stylesheets
      "<link href='#{xhive.stylesheets_path}' media='all' rel='stylesheet' type='text/css'/>".html_safe
    end

    def render_page_with(key = nil, options={})
      page = Xhive::Mapper.page_for(current_site, controller_path, action_name, key)
      render :inline => page.presenter.render_content(options), :layout => true
    rescue
      render
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
