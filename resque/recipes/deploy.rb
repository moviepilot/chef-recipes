node[:deploy].each do |application, deploy|
  redis_worker_config = YAML.load_file "#{deploy['deploy_to']}/#{node[:resque][:resque_worker_config]}" rescue next
  execute "rm /etc/monit/conf.d/resque_#{application}*.monitrc"
  
  redis_worker_config['queues'].each do |queue|
    queue_name = queue['queue_name']

    template "/etc/monit/conf.d/resque_#{application}_#{queue_name}.monitrc" do
      source "resque.monit.erb"
      variables :queue_name    => queue_name,
                :worker_amount => queue['worker'],
                :deploy        => deploy,
                :application   => application
    end
  end
  
  execute "monit reload && sleep 60 && monit restart -g resque_workers_#{application}"
end
