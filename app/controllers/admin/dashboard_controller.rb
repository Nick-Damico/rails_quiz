class Admin::DashboardController < Admin::BaseController
  def show
    selected_class_name = (params[:tab].presence || "user").capitalize
    presenter = "Admin::#{selected_class_name}Presenter".safe_constantize
    search_class = "#{selected_class_name}Search".safe_constantize
    # TODO: Add Quiz & Deck admin policy
    # default_scope = policy_scope([ :admin, @tab.safe_constantize ])
    default_scope = selected_class_name.safe_constantize.all
    search = search_class.new(default_scope, params)

    @tab = selected_class_name
    @user = current_user
    @pagy, objects = pagy(:countish, search.query)
    @objects = objects.map { |object| presenter.new(object) }
  end
end
