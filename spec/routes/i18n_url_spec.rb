require 'spec_helper'

describe :i18n_url do
  
  before(:all) do
    @route_set = ActionDispatch::Routing::RouteSet.new
    @route_set.draw do
      i18n_url do
        match "my_home" => "users#edit", as: :my_home    
        match "do_not_be_tranlate" => "users#edit", as: :not_know

        resources :why_not

      end
      
      match "not_translate" => "test#new", :as => :not_in_url
    end
    
  end
  
  before(:each) do
    I18n.locale = :fr
  end
  
  it "should translate match my_home" do 
    @route_set.url_helpers.send(:my_home_path).should == "/fr/ma_maison"
  end
  
  it "should translate match fr_my_home" do 
    @route_set.url_helpers.send(:fr_my_home_path).should == "/fr/ma_maison"
  end
  
  it "should translate resouces why_not" do
    @route_set.url_helpers.send(:fr_why_not_path).should == "/fr/pourquoi_pas"
  end
  
  it "should not translate path if it's not found locale file" do
    @route_set.url_helpers.send(:fr_not_know_path ).should == "/fr/do_not_be_tranlate"
  end
  
  it "should not translate url if the path is not in i18n_url block" do
    begin
      @route_set.url_helpers.send(:fr_not_in_url )
    rescue
      true
    end
  end
  
end