class PagesController < ApplicationController
  before_action :greet_me, :actual_time

  def home
  end

  def hello
  end

  def greet
  end

  # Greet us based on the time of the day
  # greet_me
  # input is time
  # 00 - 11 (morning)
  # 12 - 18 (afternoon)
  # 18 - 23 (evening)
  # return_value greeting
  def greet_me
    today = Time.now.strftime("%d/%m/%Y %H:%M")
    current_time = today.split(' ')[1]
    current_time = current_time.split(':')[0]

    @greeting = "Good morning #{params[:name]}" if current_time.to_i <= 11
    @greeting = "Good afternoon #{params[:name]}" if current_time.to_i <= 18
    @greeting = "Good evening #{params[:name]}" if current_time.to_i <= 23
  end

  def actual_time
    today = Time.now.strftime("%d/%m/%Y %H:%M")
    @time = today.split(' ')[1]
  end
end
