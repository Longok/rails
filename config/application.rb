require_relative "boot"

require "rails/all"


Bundler.require(*Rails.groups)

module R6Project
  class Application < Rails::Application

    config.load_defaults 6.1

    # Include the authenticity token in remote forms.
    config.action_view.embed_authenticity_token_in_remote_forms = true
    # config.active_storage.replace_on_assign_to_many = false
  end
end
