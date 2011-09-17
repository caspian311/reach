require "spec_helper"

describe HomeController do
   describe "GET index" do
      it "should show todays stats" do
         todays_stats = [HomeModel::SummaryStat.new, HomeModel::SummaryStat.new]

         HomeModel.should_receive(:todays_stats).and_return(todays_stats)

         get "index"

         assigns(:todays_stats).should == todays_stats
      end
   end
end
