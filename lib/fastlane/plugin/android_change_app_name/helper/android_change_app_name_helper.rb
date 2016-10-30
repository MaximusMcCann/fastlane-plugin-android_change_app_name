module Fastlane
  module Helper
    class AndroidChangeAppNameHelper
      # class methods that you define here become available in your action
      # as `Helper::AndroidChangeAppNameHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the android_change_app_name plugin helper!")
      end
    end
  end
end
