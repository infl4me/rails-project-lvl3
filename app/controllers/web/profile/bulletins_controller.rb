# frozen_string_literal: true

class Web::Profile::BulletinsController < Web::Profile::ApplicationController
  # GET /categories
  def index
    @q = current_user.bulletins.ransack(params[:q])
    @bulletins = @q.result.page(params[:page])
    @state_options = Bulletin.aasm.states.map { |state| [state.localized_name, state.name] }
  end
end
