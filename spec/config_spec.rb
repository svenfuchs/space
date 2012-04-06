require 'spec_helper'

describe Space::Config do
  let(:config) { Space::Config.new }

  describe 'class methods' do
    describe 'load' do
      let(:local_filename)  { File.expand_path('./.space/travis.yml') }
      let(:global_filename) { File.expand_path('~/.space/travis.yml') }

      before :each do
        File.stubs(:exists?).returns(false)
        File.stubs(:read).with(local_filename).returns('local: true')
        File.stubs(:read).with(global_filename).returns('global: true')
      end

      subject { Space::Config.load('travis') }

      it 'loads a local config file if present' do
        File.stubs(:exists?).with(local_filename).returns(true)
        subject.local?.should be_true
      end

      it 'loads globale config file if present' do
        File.stubs(:exists?).with(global_filename).returns(true)
        subject.global?.should be_true
      end

      it 'raises an exception if no config file can be found' do
        -> { subject }.should raise_error
      end
    end
  end

  describe 'defaults' do
    it 'template_dir defaults to the expanded path lib/space/templates' do
      config.template_dir.should == File.expand_path('../../lib/space/templates', __FILE__)
    end
  end
end
