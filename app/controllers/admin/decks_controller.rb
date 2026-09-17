class Admin::DecksController < Admin::BaseController
  before_action :set_deck

  def edit; end

  def update
    if @deck.update(deck_params)
      if @deck.hidden?
        @deck.unpublish! if @deck.published?
        flash[:notice] = "deck deactivated successfully"
      else
        flash[:notice] = "deck updated successfully"
      end

      redirect_to admin_dashboard_url(tab: "deck")
    else
      flash.now[:alert] = @deck.errors.full_messages
      render :edit, status: :unprocessable_content
    end
  end

  private

    def deck_params
      params.require(:deck).permit(:title, :description, :hidden)
    end

    def authorize_admin!
      authorize [ :admin, :deck ], :access?
    end

    def set_deck
      @deck = Deck.find(params[:id])
    end
end
