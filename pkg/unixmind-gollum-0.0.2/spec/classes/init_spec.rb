require 'spec_helper'
describe 'gollum' do
  context 'with default values for all parameters' do
    it { should contain_class('gollum') }
  end
end
