require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "DevicesController" do
  before { Device.destroy_all }


  # GET /devices
  context ".index" do
    before { @uri = "/devices" }
    before { @resource = Factory(:device) }
    before { @resource_not_owned = Factory(:device_not_owned) }

    it_should_behave_like "protected resource", "visit(@uri)"

    context "when logged in" do
      before { basic_auth }

      scenario "view all resources" do
        visit @uri
        page.status_code.should == 200
        should_have_valid_json
        should_have_only_owned_device @resource
      end
    end
  end
end