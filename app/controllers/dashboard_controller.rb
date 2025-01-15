class DashboardController < ApplicationController
  def index
    @total_male = Earring.live.male.count
    @total_female = Earring.live.female.count
    @total = Earring.live.count
    @total_saled = Earring.saled.count
    @total_died = Earring.dead.count
  end
end
