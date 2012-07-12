require 'rubygems'
require 'sinatra'
require 'bundler/setup'
Bundler.require(:default)

Sequel::Model.plugin(:schema)
Sequel.connect('sqlite://orders.db')

class Orders < Sequel::Model
  unless table_exists?
    set_schema do
      primary_key :id
      string :name
      string :attendance
      string :dish
      string :rice
      text :comment
      timestamp :posted_date
    end
    create_table
  end
  
  def date
    self.posted_date.strftime("%Y-%m-%d")
  end

  def formatted_message
    Rack::Utils.escape_html(self.message).gsub(/(\r\n|\r|\n)/, "<br />")
  end
end

helpers do
  include Rack::Utils; alias_method :h, :escape_html
end

get '/' do
  @orders = Orders.order_by(:posted_date.desc)
  haml :index
end

put '/order' do
  Orders.create({
    :name => request[:name],
    :attendance => request[:attendance],
    :dish => request[:dish],
    :rice => request[:rice],
    :comment => request[:comment],
    :posted_date => Date.today,
  })
  redirect '/'
end

delete '/order/:id' do
    Orders.filter('id = ?', params[:id]).delete
    redirect '/'
end

#not_found do
 # 'ファイルが存在しません'
#end
