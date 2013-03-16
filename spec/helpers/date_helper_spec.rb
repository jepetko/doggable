require 'spec_helper'

describe DogsHelper do

  before(:each) do
    @dates = [ Date.new(2012,03,16), Date.new(2011,01,01), Date.new(2012,05,05),
               Date.new(2012,07,15), Date.new(2012,12,07),Date.new(2013,02,16),
               #dates in the future
               Date.new(2030,01,01), Date.new(2013,03,17)]
    @ref_date = Date.new(2013,03,16)

    @should_refs = [ {:years => 1, :months => 0, :days => 0},
                     {:years => 2, :months => 2, :days => 15},
                     {:years => 0, :months => 10, :days => 11},
                     {:years => 0, :months => 8, :days => 1},
                     {:years => 0, :months => 3, :days => 9},
                     {:years => 0, :months => 1, :days => 0},
                     {:years => 0, :months => 0, :days => 0},
                     {:years => 0, :months => 0, :days => 0}]
  end

  it "should be true" do
     @dates.each_with_index do |val,index|
        result = date_diff_to( val, @ref_date )
        result.should eq(@should_refs[index])
     end
  end

end
