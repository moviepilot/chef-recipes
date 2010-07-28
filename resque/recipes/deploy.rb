node[:deploy].each do |application, deploy|
  queues_slug = node[:resque][:queues] == "*" ? "" : "_#{node[:resque][:queues].split(",").join("_")}"
  template "/etc/monit/conf.d/resque_#{application}#{queues_slug}.monitrc" do
    source "resque.monit.erb"
    variables :queues_slug => queues_slug,
              :deploy => deploy,
              :application => application
  end

  execute "monit reload && sleep 10 && monit restart -g resque_workers_#{application}"
end
