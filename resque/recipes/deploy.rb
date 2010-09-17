node[:deploy].each do |application, deploy|
  redis_worker_config = YAML.load_file "#{deploy['deploy_to']}/#{node[:resque][:resque_worker_config]}" rescue next
  execute "monit stop all -g resque_workers_#{application} && sleep 60"
  execute "rm -f /etc/monit/conf.d/resque_#{application}*.monitrc"
  
  redis_worker_config['queues'].each do |queue|
    queue_name = queue['queue_name']

    template "/etc/monit/conf.d/resque_#{application}_#{queue_name}.monitrc" do
      source "resque.monit.erb"
      variables :queue_name    => queue_name,
                :worker_amount => queue['worker'],
                :deploy        => deploy,
                :application   => application,
                :has_scheduler => node[:resque][:has_scheduler]
    end
  end
  
  execute "monit reload && sleep 10 && monit start -g resque_workers_#{application}"
end
