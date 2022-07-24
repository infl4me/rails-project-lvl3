# frozen_string_literal: true

class Web::Profile::ApplicationController < Web::ApplicationController
  before_action :verify_profile
end
