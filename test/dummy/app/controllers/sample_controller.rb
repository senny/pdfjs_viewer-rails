class SampleController < ApplicationController
  def show
  end

  def helper
    render :helper, layout: false
  end
end
