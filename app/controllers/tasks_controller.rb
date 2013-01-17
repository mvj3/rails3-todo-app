require 'eventmachine'
require 'net/http'

class TasksController < ApplicationController
  def create
    @task = Task.new(params[:task])
    @task.save
  end

  def update
    @task = Task.find(params[:id])
    message = {:channel => project_path(@task.project), :data => { :task_id => @task.id, :task_state => @task.state}}

    if @task.update_attributes(params[:task])
      uri = URI.parse("http://#{FAYE_IP}:9292/faye")
      Net::HTTP.post_form(uri, :message => message.to_json)
=begin
      # TODO support EM
      EM.run {
        client = Faye::Client.new("http://#{FAYE_IP}:9292/faye")
        # client.set_header('Access-Control-Allow-Origin', '*')
        client.subscribe('/faye') do |message|
          puts message.inspect
        end
        client.publish('/faye', 'text' => message.to_json)
      }
=end
    end
    render :nothing => true
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
  end
end
