require 'spec_helper'

describe 'Sprockets and Rails integration' do

  it 'copies the asset paths into the Stylus load path' do
    app = create_app
    Stylus.paths.should =~ app.assets.paths
  end

  it 'process .styl files with the asset pipeline' do
    result = fixture(:simple).last

    app = create_app
    app.assets['simple'].to_s.should == result
  end

  it 'enables @import definitions' do
    result = fixture(:import).last

    app = create_app
    app.assets['import'].to_s.should == result
  end

  it 'skips debug info by default' do
    app = create_app
    asset = app.assets['simple']
    asset.to_s.should_not match(/line 1 : #{asset.pathname}/)
  end

  it 'provides debug info if required' do
    app = create_app(:debug => true)
    asset = app.assets['simple']
    asset.to_s.should match(/line 1 : #{asset.pathname}/)
  end

  it 'compress the output if Rails is configured to compress them too' do
    result = fixture(:compressed).last

    app = create_app(:compress => true)
    app.assets['compressed'].to_s.should == result
  end
end