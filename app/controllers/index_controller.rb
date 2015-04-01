class IndexController < ApplicationController
  require 'net/http'
  require 'json'

  def index
    @user1 = params[:user1] || 'wyaeiga'
    @user2 = params[:user2] || 'avrex'
  end

  def poll
    @user1 = params[:user1] || 'wyaeiga'
    @user2 = params[:user2] || 'avrex'

    user1_route =
      URI.parse("http://api.whatpulse.org/user.php?user=#{@user1}&format=json")
    user2_route =
      URI.parse("http://api.whatpulse.org/user.php?user=#{@user2}&format=json")

    user1_req = Net::HTTP::Get.new(user1_route)
    user1_res = Net::HTTP.start(user1_route.host, user1_route.port) do |http|
      http.request(user1_req)
    end

    user2_req = Net::HTTP::Get.new(user2_route)
    user2_res = Net::HTTP.start(user2_route.host, user2_route.port) do |http|
      http.request(user2_req)
    end

    results = { :user1 => user1_res.body, :user2 => user2_res.body }

    render json: results.to_json
  end
end
