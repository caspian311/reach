require "spec_helper"

describe HomeController do
   describe "GET index" do
      it "should show todays stats" do
         todays_stats = [HomeModel::SummaryStat.new, HomeModel::SummaryStat.new]
         last_day_of_stats = Time.now

         HomeModel.should_receive(:todays_stats).and_return(todays_stats)
         HomeModel.should_receive(:last_day_of_stats).and_return(last_day_of_stats)

         get "index"

         assigns(:todays_stats).should == todays_stats
         assigns(:last_day_of_stats).should == last_day_of_stats
      end
   end
end
