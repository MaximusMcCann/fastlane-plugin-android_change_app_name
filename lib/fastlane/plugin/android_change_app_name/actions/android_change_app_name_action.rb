module Fastlane
  module Actions
    module SharedValues
      ANDROID_CHANGE_APP_NAME_ORIGINAL_NAME = :ANDROID_CHANGE_APP_NAME_ORIGINAL_NAME
    end
    class AndroidChangeAppNameAction < Action
      def self.run(params)
        require 'nokogiri'

        revertChange = params[:revertChange]
        oldName = Actions.lane_context[SharedValues::ANDROID_CHANGE_APP_NAME_ORIGINAL_NAME]

        if revertChange and oldName.to_s.strip.length != 0
          newName = oldName
          manifest = params[:manifest]
        else
          newName = params[:newName]
          manifest = params[:manifest]
        end

        doc = File.open(manifest) { |f|
          @doc = Nokogiri::XML(f)

          originalName = nil

          @doc.css("application").each do |response_node|
            originalName = response_node["android:label"]
            response_node["android:label"] = newName
          end

          Actions.lane_context[SharedValues::ANDROID_CHANGE_APP_NAME_ORIGINAL_NAME] = originalName

          File.write(manifest, @doc.to_xml)
        }

      end

      def self.description
        "Changes the manifest's label attribute (appName).  Stores the original name for revertinng."
      end

      def self.authors
        ["MaximusMcCann"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        "Changes the apk manifest file's label attribute (appName).  Stores the original label value for reverting later."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :newName,
                                  env_name: "",
                               description: "The new name for the app",
                                  optional: true,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :manifest,
                                  env_name: "",
                               description: "Optional custom location for AndroidManifest.xml",
                                  optional: false,
                                      type: String,
                             default_value: "app/src/main/AndroidManifest.xml"),
          FastlaneCore::ConfigItem.new(key: :revertChange,
                                  env_name: "",
                               description: "if 'true' will use ANDROID_CHANGE_APP_NAME_ORIGINAL_NAME to reset the app name",
                                  optional: true,
                             default_value: false)
        ]
      end

      def self.output
        [
          ['ANDROID_CHANGE_APP_NAME_ORIGINAL_NAME', 'The original app name.']
        ]
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end

    class AndroidChangeAppNameRevertAction < Action
      def self.run(params)
        require 'nokogiri'

        oldName = Actions.lane_context[SharedValues::ANDROID_CHANGE_APP_NAME_ORIGINAL_NAME]

        if oldName.to_s.strip.length != 0
          manifest = params[:manifest]
        else
          UI.error("no string for ANDROID_CHANGE_APP_NAME_ORIGINAL_NAME.  Have you run android_change_app_name?")
        end

        doc = File.open(manifest) { |f|
          @doc = Nokogiri::XML(f)

          @doc.css("application").each do |response_node|
            originalName = response_node["android:label"]
            response_node["android:label"] = oldName
          end

          File.write(manifest, @doc.to_xml)
        }

      end

      def self.description
        "Reverts the manifest's label attribute (appName) from ANDROID_CHANGE_APP_NAME_ORIGINAL_NAME"
      end

      def self.authors
        ["MaximusMcCann"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        "Reverts the manifest's label attribute (appName) from ANDROID_CHANGE_APP_NAME_ORIGINAL_NAME"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :manifest,
                                  env_name: "",
                               description: "Optional custom location for AndroidManifest.xml",
                                  optional: false,
                                      type: String,
                             default_value: "app/src/main/AndroidManifest.xml")
        ]
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end
  end
end
