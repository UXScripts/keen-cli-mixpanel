require 'spec_helper'

describe KeenCli::Mixpanel do
  
  def start(str=nil)
    KeenCli::Mixpanel.start(str ? str.split(" ") : [])
  end
  
  it 'prints help by default' do
    _, options = start
    expect(_).to be_empty
  end
  
  it 'prints version info if -v is used' do
    _, options = start "-v"
    expect(_).to match /version/
  end

  describe 'export' do
    it 'fails if no options are specified' do
      _, options = start "export"
      expect(_).to be_nil
    end
  end

  describe 'import' do
    it 'fails if no options are specified' do
      _, options = start "import"
      expect(_).to be_nil
    end
  end

end