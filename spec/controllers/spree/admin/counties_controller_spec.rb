require 'spec_helper'

describe Spree::Admin::CountiesController do
  describe 'GET #index' do
    it { should use_before_action(:load_data) }
  end
end