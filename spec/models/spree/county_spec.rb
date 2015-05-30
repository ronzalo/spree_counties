require 'spec_helper'

describe Spree::County do
  ##############
  # attributes #
  ##############
  it { expect(subject).to respond_to :name }
  it { expect(subject).to respond_to :state_id }

  ##############
  # association #
  ##############
  it { should belong_to(:state) }

  ##############
  # validations #
  ##############
  it { should validate_presence_of(:name) }
end