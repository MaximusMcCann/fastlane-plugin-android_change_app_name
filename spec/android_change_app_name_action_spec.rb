describe Fastlane::Actions::AndroidChangeAppNameAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The android_change_app_name plugin is working!")

      Fastlane::Actions::AndroidChangeAppNameAction.run(nil)
    end
  end
end
