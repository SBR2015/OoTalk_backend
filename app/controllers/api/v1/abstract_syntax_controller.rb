# OoTalkライブラリの読み込み
Dir[File.expand_path('../../../assets/OoTalk/lib/', __FILE__) << '/*.rb'].each do |file|
  require file
end

class Api::V1::AbstractSyntaxController < ApplicationController
  def index
    @asl = AbstractSyntaxLists.create(:ja)
    render :json => @asl.to_json
  end
end
