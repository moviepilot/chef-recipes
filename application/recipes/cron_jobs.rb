node[:deploy].each do |application, deploy|
  next if deploy[:application_type]  != 'rails'

  execute "create crontab" do
    command ". /etc/environment; cd #{deploy[:current_path]} && whenever --update . || true"
  end
end

