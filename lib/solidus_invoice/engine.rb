# frozen_string_literal: true

module SolidusInvoice
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'solidus_invoice'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/overrides/**/*_override*.rb')) do |c|
        require_dependency(c)
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
